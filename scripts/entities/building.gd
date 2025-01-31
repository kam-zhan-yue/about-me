class_name Building
extends Node2D

@export var title := "Building"
@export var id := "SCHOOL"
@onready var entry := $Entry as Marker2D
@onready var title_label := %TitleLabel as  RichTextLabel
@onready var enter_label := %EnterLabel as RichTextLabel

@onready var interaction := $Entry/Interaction as Area2D
var interactive := false
var played := false

func _ready() -> void:
	Global.set_inactive(enter_label)

func _input(event: InputEvent) -> void:
	if not played and interactive and Input.is_key_pressed(KEY_SPACE):
		played = true
		Global.set_inactive(enter_label)
		Game.activate_sequence("SCHOOL")

func _on_interaction_area_entered(area: Area2D) -> void:
	Global.set_active(enter_label)
	interactive = true


func _on_interaction_area_exited(area: Area2D) -> void:
	Global.set_inactive(enter_label)
	interactive = false
