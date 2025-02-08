class_name Firezone
extends Node2D

@onready var firewall := %Firewall as Firewall
@onready var fire_start := %FireStart as Marker2D
@onready var fire_end := %FireEnd as Marker2D

var activated := false
var timer = 0.0
const TIME_TO_TARGET := 3.0
var original_wall := Vector2.ZERO

func activate() -> void:
	Game.camera.set_mode(Camera.Mode.ManualControl)
	await firewall.activate()
	self.timer = 0.0
	self.original_wall = firewall.global_position
	self.activated = true

func _process(delta: float) -> void:
	if Game.paused: return
	if not self.activated: return
	var next_pos := fire_start.global_position.lerp(fire_end.global_position, timer / TIME_TO_TARGET)
	Game.camera.global_position.x = next_pos.x
	var displacement := next_pos - fire_start.global_position
	firewall.global_position.x = self.original_wall.x + displacement.x

	timer += delta
	if timer >= TIME_TO_TARGET:
		self.deactivate()

func deactivate() -> void:
	self.activated = false
	Game.camera.set_mode(Camera.Mode.FollowPlayer)
	await firewall.deactivate()
