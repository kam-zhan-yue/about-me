class_name Flagpole
extends Node2D

const FLAG_FALL_SPEED = 150.0
var activated := false
@onready var target := %Target as Marker2D
@onready var flag := %Flag as TileMapLayer

func _on_area_2d_body_entered(body: Node2D) -> void:
	if self.activated: return
	if body is Player:
		self.activated = true
		print("Collided with player")
		Game.player.flagpole(target.global_position)
		fall()

func fall() -> void:
	var time = ( -flag.position.y) / Flagpole.FLAG_FALL_SPEED
	if time < 0:
		time = 0
	var next_pos = Vector2(flag.position.x,  target.position.y)
	var tween = get_tree().create_tween()
	tween.tween_property(flag, "position", Vector2.ZERO, time)
