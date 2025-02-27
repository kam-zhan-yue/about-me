class_name GameManager
extends Node2D

@onready var player := %Player as Player
@onready var camera := %Camera2D as Camera
@onready var ui :=  %UI as UI
@onready var audio_manager := %AudioManager as AudioManager
@onready var point_holder := %PointHolder as Node2D

const SETTINGS = preload("res://resources/game_settings.tres")

func _ready() -> void:
	Game.init(player, camera, Date.new(SETTINGS.start_year, SETTINGS.start_month), ui, audio_manager, point_holder)
