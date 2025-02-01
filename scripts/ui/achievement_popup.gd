class_name AchievementPopup
extends Control

var data: AchievementData

@onready var title := %Title as RichTextLabel
@onready var description := %Description as RichTextLabel
@onready var video := %Video as VideoStreamPlayer
@onready var image := %Image as TextureRect
@onready var next_button := %Next as Button
@onready var previous_button := %Previous as Button
@onready var ok_button := %OkButton as Button

var page_index := 0

func _ready() -> void:
	Achievements.on_achievement.connect(_on_achievement)
	Global.set_inactive(self)

func _on_achievement(achievement: AchievementData) -> void:
	init(achievement)
	Global.set_active(self)

func init(achievement_data: AchievementData) -> void:
	self.data = achievement_data
	print("Data is ", achievement_data)
	title.text = Global.wrap_center(data.title)
	page_index = 0
	init_page(data.pages[0])
	Game.pause(true)

func init_page(page_data: PageData) -> void:
	var file = str("res://media/", page_data.filename)
	var media = load(file)
	if page_data.media == PageData.Media.IMAGE:
		print("Opening Image: ", file)
		Global.set_inactive(video)
		Global.set_active(image)
		image.texture = media as Texture2D
	else:
		print("Opening Video: ", file)
		Global.set_inactive(image)
		Global.set_active(video)
		video.stream = media as VideoStream
		video.loop = true
		video.play()
	description.text = Global.wrap_center(page_data.description)
	check_footer()

func check_footer() -> void:
	var has_previous := page_index > 0 and len(data.pages) > 1
	var has_next := page_index < len(data.pages) - 1
	var last_page := page_index == len(data.pages) - 1
	Global.active(previous_button, has_previous)
	Global.active(next_button, has_next)
	Global.active(ok_button, last_page)


func _on_ok_button_pressed() -> void:
	Global.set_inactive(self)
	Game.pause(false)


func _on_previous_pressed() -> void:
	self.page_index -= 1
	init_page(data.pages[self.page_index])


func _on_next_pressed() -> void:
	self.page_index += 1
	init_page(data.pages[self.page_index])
