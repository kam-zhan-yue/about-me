class_name VolumePopup
extends Control

@onready var sliders := %Sliders as VBoxContainer
var showing := false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Global.set_inactive(sliders)

func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("ui_slider"):
		showing = !showing
		Global.active(sliders, showing)
