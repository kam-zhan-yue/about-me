class_name EndGamePopup
extends Control
@onready var timer := $Timer as Timer

func _ready() -> void:
	Global.set_inactive(self)
	Game.on_end_game.connect(_end_game)

func _end_game() -> void:
	timer.start()
	await timer.timeout
	Global.set_active(self)
