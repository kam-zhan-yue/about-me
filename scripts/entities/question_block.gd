class_name QuestionBlock
extends Node2D

@onready var sprite := $AnimatedSprite2D as AnimatedSprite2D

var active := true
signal hit

func _ready() -> void:
	sprite.play("default")

func _on_area_2d_area_entered(_area: Area2D) -> void:
	if not active: return
	hit.emit()
	active = false
	sprite.play("empty")
	play_animation()

func play_animation() -> void:
	var tween = get_tree().create_tween()
	var original_pos = position
	tween.tween_property(self, "position", original_pos + Vector2(0, -5), 0.15).set_trans(Tween.TRANS_SINE)
	tween.tween_property(self, "position", original_pos, 0.15).set_trans(Tween.TRANS_SINE)
	pass
