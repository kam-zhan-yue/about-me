class_name QuestionBlock
extends Node2D

@onready var sprite := $AnimatedSprite2D as AnimatedSprite2D
@onready var bump := %Bump as AudioStreamPlayer2D

var active := true
signal pre_hit
signal hit

func _ready() -> void:
	sprite.play("default")

func _on_area_2d_area_entered(area: Area2D) -> void:
	if not active: return
	if area.get_parent() is Player:
		bump.play()
		active = false
		sprite.play("empty")
		play_animation()

func play_animation() -> void:
	var tween = get_tree().create_tween()
	var original_pos = position
	tween.tween_callback(_emit_pre_hit)
	tween.tween_property(self, "position", original_pos + Vector2(0, -5), 0.15).set_trans(Tween.TRANS_SINE)
	tween.tween_callback(_emit_hit)
	tween.tween_property(self, "position", original_pos, 0.15).set_trans(Tween.TRANS_SINE)

func _emit_pre_hit() -> void:
	pre_hit.emit()

func _emit_hit() -> void:
	hit.emit()
