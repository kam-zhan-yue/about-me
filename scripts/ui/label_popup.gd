class_name LabelPopup
extends HBoxContainer

var buttons = {}

func _ready() -> void:
	for child in get_children():
		self.buttons[child.name] = child
	

func show_achievement(achievement: AchievementData) -> void:
	var keys: Array[String] = []
	for tag in achievement.tags:
		keys.push_back(str(AchievementData.Tag.keys()[tag]))

	for button in self.buttons:
		var active = button in keys
		Global.active(self.buttons[button], active)
