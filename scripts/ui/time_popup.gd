class_name TimePopup
extends Control

@onready var time_label := %TimeLabel as RichTextLabel

var started := false
var time := 0.0

func _ready() -> void:
	Game.on_date_changed.connect(_start_timer)
	Game.on_end_game.connect(_end_timer)

func _process(delta: float) -> void:
	if not self.started: return
	time += delta
	var seconds = int(time)
	time_label.text = Global.wrap_center(str(seconds))

func _start_timer(_date: Date) -> void:
	self.started = true
	Game.on_date_changed.disconnect(_start_timer)

func _end_timer() -> void:
	self.started = false
