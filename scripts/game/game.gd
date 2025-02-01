extends Node

# Variables
var player: Player
var camera: Camera
var date: Date

# Signals
signal on_date_changed(date: Date)

func init(p: Player = null, c: Camera = null, start_date: Date = null) -> void:
	self.player = p
	self.camera = c
	self.date = start_date

func update_date(new_date: Date) -> void:
	if date.years != new_date.years or date.months != new_date.months:
		date = new_date
		on_date_changed.emit(date)

func in_bounds(pos_x: float) -> bool:
	var camera_screen_pos = camera.get_screen_center_position().x 
	var camera_width = (camera.get_viewport_rect().size.x / (2 * camera.zoom.x))
	var left_bound = camera_screen_pos - camera_width
	var right_bound = camera_screen_pos + camera_width
	return left_bound < pos_x and pos_x < right_bound

func pause(value: bool) -> void:
	Engine.time_scale = 0.0 if value else 1.0
