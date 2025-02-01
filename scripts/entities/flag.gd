class_name Flag
extends Node2D

const OFFSET = Vector2(0, 48)
var original_pos := Vector2.ZERO

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	original_pos = position
	position += OFFSET


func raise() -> void:
	var tween = get_tree().create_tween()
	tween.tween_property(self, "position", original_pos, 1.6).set_trans(Tween.TRANS_LINEAR)
