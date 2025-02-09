class_name BowserLevel
extends Node2D

@onready var start := %Start as Marker2D
@onready var tiles := %Tiles as Node2D
@onready var axe := %Axe as Node2D
@onready var bowser := %Bowser as Bowser
@onready var recovery := %Recovery as Marker2D

var started := false
var bridge: Array[Node] = []

const INTERVAL = 0.03

signal on_complete

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	bridge = tiles.get_children()

func _process(_delta: float) -> void:
	if started: return
	if Game.player.global_position.x > start.global_position.x:
		bowser.start()
		self.started = true

func _input(_event: InputEvent) -> void:
	# If we happen to fall, just bring back up
	if self.started and Game.player.global_position.y > 0 and Input.is_action_just_pressed("ui_pause"):
		Game.player.global_position = recovery.global_position


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is Player:
		end_level()

func end_level() -> void:
	axe.queue_free()
	bowser.stop()
	Game.player.active = false
	for block in bridge:
		block.queue_free()
		await Global.wait(INTERVAL)
	bowser.fall()
	Game.player.active = true
	on_complete.emit()
	
