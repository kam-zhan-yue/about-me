extends Node

# Variables
var player: Player
var camera: Camera
var date: Date
var ui: UI
var audio: AudioManager
var holder: Node2D
var paused := false
var world = '1-1'
var points := 0
var coins := 0

# Signals
signal on_date_changed(date: Date)
signal on_world_changed(world: String)
signal on_end_game
signal on_stop_timer
signal on_points_changed(points: int)
signal on_coins_changed(coins: int)

func init(p: Player = null, c: Camera = null, start_date: Date = null, ui_popup: UI = null, audio_manager: AudioManager = null, point_holder: Node2D = null) -> void:
	self.player = p
	self.camera = c
	self.date = start_date
	self.ui = ui_popup
	self.audio = audio_manager
	self.holder = point_holder
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
	player.active = false
	on_end_game.emit()

func set_world(new_world: String) -> void:
	self.world = new_world
	on_world_changed.emit(self.world)

func pause_systems(pause: bool) -> void:
	self.paused = pause
	self.player.active = !pause

func stop_timer() -> void:
	self.on_stop_timer.emit()

func add_points(value: int) -> void:
	self.points += value
	self.on_points_changed.emit(points)

func add_coins(value: int) -> void:
	self.coins += value
	self.on_coins_changed.emit(coins)
