class_name UI
extends CanvasLayer

@onready var game_popup := %GamePopup as GamePopup

func init() -> void:
	game_popup.init()
