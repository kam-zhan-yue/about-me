class_name BowserFireball
extends Node2D

const SPEED = 200.0

func _process(delta: float) -> void:
	global_position.x -= SPEED * delta
