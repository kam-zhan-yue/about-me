class_name EntityPopup
extends Control

const BUILDING_ITEM = preload("res://scenes/building_popup_item.tscn")

func init() -> void:
	for building in Game.buildings:
		print("Bulding: ", building)
		var popup_item = BUILDING_ITEM.instantiate() as BuildingPopupItem
		add_child(popup_item)
		popup_item.init(building)
