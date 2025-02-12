class_name AudioManager
extends Node2D

@onready var ground := %Ground as AudioStreamPlayer2D
@onready var castle := %Castle as AudioStreamPlayer2D
@onready var princess := %Princess as AudioStreamPlayer2D
@onready var world_clear := %WorldClear as AudioStreamPlayer2D

var current: AudioStreamPlayer2D

func _ready() -> void:
	Game.on_date_changed.connect(_play_ground)

func _play_ground(_date: Date) -> void:
	Game.on_date_changed.disconnect(_play_ground)
	play(ground)

func play_world_1_1_clear() -> void:
	play(world_clear)

func play_world_8_4_start() -> void:
	play(castle)

func play_princess() -> void:
	play(world_clear)
	await Global.wait(5.0)
	play(princess)

func play(audio: AudioStreamPlayer2D) -> void:
	print("Playing ", audio.name)
	stop()
	current = audio
	current.play()

func stop() -> void:
	if current:
		current.stop()
