class_name BuildingPopupItem
extends Control

const ENTRY_OFFSET_Y = -25.0
const TITLE_OFFSET_Y = -60.0

@onready var entry_label = %EntryLabel as RichTextLabel
@onready var title_label = %TitleLabel as RichTextLabel
var building: Building

func init(b: Building) -> void:
	position = Vector2(-100, -100)
	Global.set_inactive(entry_label)
	building = b
	set_title_text(building.title)
	building.show.connect(_on_show)
	building.hide.connect(_on_hide)

func _process(_delta: float) -> void:
	if not building: return
	var camera := get_viewport().get_camera_2d()
	var screen_center := camera.get_screen_center_position()
	var difference := building.entry.global_position - screen_center
	var screen_position := get_screen_center() + difference * Global.zoom
	var offset_position := Vector2(screen_position.x, screen_position.y + ENTRY_OFFSET_Y * Global.zoom)
	position = offset_position
	print(position)
	#position = Vector2(0.0, 0.0)

func get_screen_center() -> Vector2:
	var rect := get_viewport_rect().size * 0.5
	return Vector2(rect.x - size.x * 0.5, rect.y - size.y * 0.5)


func get_bbtext(text: String) -> String:
	var center = str('[center]', text, '[/center]')
	var outline = str('[outline_size=32]', center, '[/outline_size]')
	return outline
	

func set_entry_text(text: String) -> void:
	entry_label.text = get_bbtext(text)

func set_title_text(text: String) -> void:
	title_label.text = get_bbtext(text)

func _on_show():
	Global.set_active(entry_label)

func _on_hide():
	Global.set_inactive(entry_label)
