class_name GameManager
extends Node2D

@onready var player := %Player as Player
@onready var camera := %Camera2D as Camera

const SETTINGS = preload("res://resources/game_settings.tres")


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Game.init(player, camera, Date.new(SETTINGS.start_year, SETTINGS.start_month))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
