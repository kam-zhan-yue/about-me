class_name GamePopup
extends Control

@onready var date_popup := %DatePopup as DatePopup
@onready var entity_popup := %EntityPopup as EntityPopup

func init() -> void:
	date_popup.init()
	entity_popup.init()
