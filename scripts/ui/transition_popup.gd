class_name TransitionPopup
extends Control

@onready var shader := %Shader as ColorRect
const MAX := 1.2
const MIN := 0.0
const TIME := 0.5

func init() -> void:
	pass

func fade_in() -> void:
	var tween = create_tween()
	tween.tween_property(shader.material, 'shader_parameter/radius', MIN, TIME)
	await Global.wait(TIME)

func fade_out() -> void:
	var tween = create_tween()
	tween.tween_property(shader.material, 'shader_parameter/radius', MAX, TIME)
	await Global.wait(TIME)
	
