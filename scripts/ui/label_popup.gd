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
	print("Keys are: ", keys)

	for button in self.buttons:
		var active = button in keys
		print(str("Button ", button, " is active: ", active))
		Global.active(self.buttons[button], active)
