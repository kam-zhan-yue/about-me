class_name TimePopup
extends Control

@onready var time_label := %TimeLabel as RichTextLabel

var time := 0.0

func _process(delta: float) -> void:
	time += delta
	var seconds = int(time)
	time_label.text = Global.wrap_center(str(seconds))
