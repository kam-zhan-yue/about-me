extends Node

# Variables
var player: Player
var camera: Camera
var date: Date
var ui: UI

# Signals
signal on_date_changed(date: Date)
signal on_end_game

func init(p: Player = null, c: Camera = null, start_date: Date = null, ui_popup: UI = null) -> void:
	self.player = p
	self.camera = c
	self.date = start_date
	self.ui = ui_popup
	ui.init()

func update_date(new_date: Date) -> void:
	if date.years != new_date.years or date.months != new_date.months:
		date = new_date
		on_date_changed.emit(date)

func in_left_bounds(pos_x: float) -> bool:
	var camera_screen_pos := get_screen_pos()
	var camera_width := get_width()
	var left_bound = camera_screen_pos - camera_width
	return left_bound < pos_x

func in_right_bounds(pos_x: float) -> bool:
	var camera_screen_pos = get_screen_pos()
	var camera_width = get_width()
	var right_bound = camera_screen_pos + camera_width
	return pos_x < right_bound

func get_screen_pos() -> float:
	return camera.get_screen_center_position().x

func get_width() -> float:
	return (camera.get_viewport_rect().size.x / (2 * camera.zoom.x))

func transition_in() -> void:
	await ui.transition_in()

func transition_out() -> void:
	await ui.transition_out()

func end_game() -> void:
	player.fade_out()
	on_end_game.emit()
