class_name Points
extends Sprite2D

const FADE_TIME = 0.2
const ANIMATE_TIME = 0.8
const MOVE_DISTANCE = 16.0

func _ready() -> void:
	animate()

func animate() -> void:
	self.modulate = Global.CLEAR
	var fade_tween = get_tree().create_tween()
	fade_tween.tween_property(self, "modulate", Global.WHITE, FADE_TIME)
	fade_tween.tween_interval(ANIMATE_TIME - FADE_TIME * 2.0)
	fade_tween.tween_property(self, "modulate", Global.CLEAR, FADE_TIME)

	var move_tween = get_tree().create_tween()
	move_tween.tween_property(self, "position", self.position + Vector2.UP * MOVE_DISTANCE, ANIMATE_TIME)
	move_tween.tween_callback(self.queue_free)
