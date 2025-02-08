class_name UI
extends CanvasLayer

@onready var game_popup := %GamePopup as GamePopup
@onready var date_popup := %DatePopup as LargeDatePopup
@onready var transition_popup := %TransitionPopup as TransitionPopup

func init() -> void:
	game_popup.init()
	date_popup.init()
	transition_popup.init()
	Achievements.on_countdown_started.connect(_on_countdown_started)
	Achievements.on_countdown_completed.connect(_on_countdown_completed)
	Achievements.on_achievement.connect(_on_achievement)
	Achievements.on_done_showing.connect(_on_done_showing)

func _on_countdown_started() -> void:
	await Global.fade_out(game_popup)
	await Global.fade_in(date_popup)

func _on_countdown_completed() -> void:
	await Global.fade_out(date_popup)
	await Global.fade_in(game_popup)

func transition_in() -> void:
	await transition_popup.fade_in()
	
func transition_out() -> void:
	await transition_popup.fade_out()

func _on_achievement(_achievement: AchievementData) -> void:
	Global.fade_out(game_popup)

func _on_done_showing() -> void:
	Global.fade_in(game_popup)
