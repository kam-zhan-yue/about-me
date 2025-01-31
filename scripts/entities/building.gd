class_name Building
extends Node2D

@export var title := "Building"
@export var id := "SCHOOL"
@onready var entry := $Entry as Marker2D

@onready var interaction := $Entry/Interaction as Area2D
var interactive := false
var played := false

signal show
signal hide

func _ready() -> void:
	interaction.body_entered.connect(on_enter)
	interaction.body_exited.connect(on_exit)

func _input(event: InputEvent) -> void:
	if not played and interactive and Input.is_key_pressed(KEY_SPACE):
		played = true
		hide.emit()
		Game.activate_sequence("SCHOOL")

func on_enter(_body: Node2D) -> void:
	show.emit()
	interactive = true

func on_exit(_body: Node2D) -> void:
	hide.emit()
	interactive = true
