class_name GamePopup
extends Control

@onready var date_popup := %DatePopup as DatePopup

func init() -> void:
	date_popup.init()
