class_name BrickBlock
extends Node2D

@onready var bump := %Bump as AudioStreamPlayer2D

var active := true

func _on_area_2d_area_entered(area: Area2D) -> void:
	if not active: return
	if area.get_parent() is Player:
		bump.play()
		active = false
		play_animation()

func play_animation() -> void:
	var tween = get_tree().create_tween()
	var original_pos = position
	tween.tween_property(self, "position", original_pos + Vector2(0, -5), 0.15).set_trans(Tween.TRANS_SINE)
	tween.tween_property(self, "position", original_pos, 0.15).set_trans(Tween.TRANS_SINE)
	tween.tween_callback(_end_animation)

func _end_animation() -> void:
	self.active = true
