class_name TitlePopup
extends Control

var started := false
var time := 0.0

func _ready() -> void:
	Game.on_date_changed.connect(_start_timer)

func _start_timer(_date: Date) -> void:
	Global.set_inactive(self)
	Game.on_date_changed.disconnect(_start_timer)
