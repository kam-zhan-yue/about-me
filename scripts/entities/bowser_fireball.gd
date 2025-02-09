class_name BowserFireball
extends Node2D

@onready var animated_sprite_2d := $AnimatedSprite2D as AnimatedSprite2D

const SPEED = 100.0

func _ready() -> void:
	animated_sprite_2d.play()

func _process(delta: float) -> void:
	global_position.x -= SPEED * delta

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is Player:
		queue_free()
