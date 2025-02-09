class_name BowserLevel
extends Node2D

@onready var tiles: Node2D = %Tiles
@onready var axe: Node2D = %Axe

var bridge: Array[Node] = []

const INTERVAL = 0.03

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	bridge = tiles.get_children()


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is Player:
		end_level()

func end_level() -> void:
	axe.queue_free()
	Game.player.active = false
	for block in bridge:
		block.queue_free()
		await Global.wait(INTERVAL)
	Game.player.active = true
	
