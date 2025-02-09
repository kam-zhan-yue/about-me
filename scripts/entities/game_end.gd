class_name GameEnd
extends Node2D

var activated := false
signal on_complete
@onready var threshold := %Threshold as Marker2D
@onready var labels := %Labels as Node2D

const INTERVAL = 1.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for child in labels.get_children():
		Global.set_inactive(child)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if self.activated: return
	if Game.player.global_position.x >= threshold.global_position.x:
		activate()

func activate() -> void:
	self.activated = true
	for child in labels.get_children():
		Global.set_active(child)
		await Global.wait(INTERVAL)
