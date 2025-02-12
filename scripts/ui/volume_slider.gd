class_name VolumeSlider
extends HSlider

@export var bus_name := ""
var bus_index := 0

func _ready() -> void:
	bus_index = AudioServer.get_bus_index(bus_name)
	value_changed.connect(_on_value_changed)
	var bus_volume = AudioServer.get_bus_volume_db(bus_index)
	var percentage = db_to_linear(bus_volume)
	set_value_no_signal(percentage)

func _on_value_changed(value: float) -> void:
	print("What", value)
	AudioServer.set_bus_volume_db(
		bus_index,
		linear_to_db(value)
	)
