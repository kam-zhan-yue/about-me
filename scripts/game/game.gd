extends Node

# Variables
var player: Player
var camera: Camera
var date: Date

func init(player: Player = null, camera: Camera = null, start_date: Date = null) -> void:
	self.player = player
	self.camera = camera
	self.date = start_date
	

func in_bounds(pos_x: float) -> bool:
	var camera_screen_pos = camera.get_screen_center_position().x 
	var camera_width = (camera.get_viewport_rect().size.x / (2 * camera.zoom.x))
	var left_bound = camera_screen_pos - camera_width
	return left_bound < pos_x
