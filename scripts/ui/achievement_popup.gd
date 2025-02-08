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
@onready var label_holder := %LabelHolder as LabelPopup

var showing := false
var page_index := 0

func _ready() -> void:
	video.volume = 0
	Achievements.on_achievement.connect(_on_achievement)
	Global.set_inactive(self)

func show_popup() -> void:
	Game.pause_systems(true)
	self.scale = Vector2.ZERO
	var tween = get_tree().create_tween()
	tween.tween_property(self, "scale", Vector2(1, 1), 0.6).set_trans(Tween.TRANS_EXPO)
	tween.tween_callback(_set_showing_true)

func _set_showing_true() -> void:
	self.showing = true

func hide_popup() -> void:
	showing = false
	var tween = get_tree().create_tween()
	tween.tween_property(self, "scale", Vector2.ZERO, 0.6).set_trans(Tween.TRANS_EXPO)
	tween.tween_callback(_hide)

func _hide() -> void:
	Global.set_inactive(self)
	Game.pause_systems(false)

func _on_achievement(achievement: AchievementData) -> void:
	init(achievement)
	label_holder.show_achievement(achievement)
	
	Global.set_active(self)

func init(achievement_data: AchievementData) -> void:
	show_popup()
	self.data = achievement_data
	title.text = Global.wrap_center(data.title)
	page_index = 0
	init_page(data.pages[0])
	
func _input(event: InputEvent) -> void:
	if Input.is_key_pressed(KEY_SPACE) and is_last_page() and showing:
		_on_ok_button_pressed()
	elif Input.is_key_pressed(KEY_LEFT) and has_previous():
		_on_previous_pressed()
	elif Input.is_key_pressed(KEY_RIGHT) and has_next():
		_on_next_pressed()

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
		video.volume = 0
		video.play()
	description.text = Global.wrap_center(page_data.description)
	check_footer()

func check_footer() -> void:
	Global.active(previous_button, has_previous())
	Global.active(next_button, has_next())
	Global.active(ok_button, is_last_page())

func has_previous() -> bool:
	return page_index > 0 and len(data.pages) > 1

func has_next() -> bool:
	return page_index < len(data.pages) - 1

func is_last_page() -> bool:
	return page_index == len(data.pages) - 1

func _on_ok_button_pressed() -> void:
	hide_popup()


func _on_previous_pressed() -> void:
	self.page_index -= 1
	init_page(data.pages[self.page_index])


func _on_next_pressed() -> void:
	self.page_index += 1
	init_page(data.pages[self.page_index])
