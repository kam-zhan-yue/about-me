class_name AudioManager
extends Node2D

@onready var ground := %Ground as AudioStreamPlayer2D
@onready var castle := %Castle as AudioStreamPlayer2D
@onready var princess := %Princess as AudioStreamPlayer2D
@onready var world_clear := %WorldClear as AudioStreamPlayer2D

var current: AudioStreamPlayer2D

const WORLD_CLEAR = 6.26

func _ready() -> void:
	if Game.world == '1-1':
		print("Game world is ", Game.world)
		play(ground)

func play_world_1_1_clear() -> void:
	play(world_clear)

func play_world_8_4_start() -> void:
	play(castle)

func play_princess() -> void:
	play(world_clear)
	await Global.wait(WORLD_CLEAR)
	play(princess)

func play(audio: AudioStreamPlayer2D) -> void:
	print("Playing ", audio.name)
	stop()
	current = audio
	current.play()

func stop() -> void:
	if current:
		current.stop()
