class_name UI
extends CanvasLayer

@onready var game_popup := %GamePopup as GamePopup
@onready var date_popup := %DatePopup as LargeDatePopup

func init() -> void:
	game_popup.init()
	date_popup.init()
	Achievements.on_countdown_started.connect(_on_countdown_started)
	Achievements.on_countdown_completed.connect(_on_countdown_completed)

func _on_countdown_started() -> void:
	await Global.fade_out(game_popup)
	await Global.fade_in(date_popup)
	print("Showing Date")

func _on_countdown_completed() -> void:
	await Global.fade_out(date_popup)
	await Global.fade_in(game_popup)
