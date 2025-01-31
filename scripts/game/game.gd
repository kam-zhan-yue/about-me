extends Node

# Variables
var player: Player
var camera: Camera
var date: Date
var buildings: Array[Building] = []

var timer := 0.0
var time := 0.0
var start_date := Date.new()
var end_date := Date.new()

# Signals
signal on_date_changed(date: Date)

func init(p: Player = null, c: Camera = null, start_date: Date = null) -> void:
	self.player = p
	self.camera = c
	self.date = start_date

func add_building(building: Building):
	buildings.push_back(building)

func update_date(new_date: Date) -> void:
	if date.years != new_date.years or date.months != new_date.months:
		date = new_date
		on_date_changed.emit(date)

func in_bounds(pos_x: float) -> bool:
	var camera_screen_pos = camera.get_screen_center_position().x 
	var camera_width = (camera.get_viewport_rect().size.x / (2 * camera.zoom.x))
	var left_bound = camera_screen_pos - camera_width
	return left_bound < pos_x

func _process(delta: float) -> void:
	if timer < time:
		var p := timer / time
		update_date(start_date.lerp_date(end_date, p))
		timer += delta
		if timer >= time:
			end_sequence()

func activate_sequence(id: String) -> void:
	if id == "SCHOOL":
		school_sequence()
	elif id == "KURECHII":
		kurechii_sequence()
	elif id == "SCS":
		scs_sequence()
	elif id == "UPTICK":
		uptick_sequence()
	elif id == "UNIVERSITY":
		university_sequence()

func school_sequence() -> void:
	await player.fade_out()
	start_date = Date.new(2008, 1)
	end_date = Date.new(2021, 12)
	timer = 0.0
	time = 10.0

func kurechii_sequence() -> void:
	pass
	
func scs_sequence() -> void:
	pass

func uptick_sequence() -> void:
	pass
	
func university_sequence() -> void:
	pass

func end_sequence() -> void:
	await player.fade_in()
