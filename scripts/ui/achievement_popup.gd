class_name AchievementPopup
extends Control

var data: AchievementData

@onready var title := %Title as RichTextLabel
@onready var description := %Description as RichTextLabel
@onready var navigation_holder := %NavigationHolder as NavigationPopupItem
@onready var video := %Video as VideoStreamPlayer
@onready var image := %Image as TextureRect

func _ready() -> void:
	Game.on_achievement.connect(_on_achievement)

func _on_achievement(achievement: Game.Achievement) -> void:
	pass

func init(achievement_data: AchievementData) -> void:
	self.data = achievement_data
	title.text = Global.wrap_center(data.title)

func init_page(page_data: PageData) -> void:
	var file = str("res://media/", page_data.filename)
	print("Opening File: ", file)
	var media = load(file)
	if page_data.media == PageData.Media.IMAGE:
		Global.set_inactive(video)
		Global.set_active(image)
		image.texture = media as Texture2D
	else:
		Global.set_inactive(image)
		Global.set_active(video)
	description.text = Global.wrap_center(page_data.description)
