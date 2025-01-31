class_name NavigationPopupItem
extends Control

@onready var previous := %Previous as Button
@onready var next := %Next as Button

var data: AchievementData

signal on_page(int)

func init(achievement_data: AchievementData) -> void:
	self.data = achievement_data
