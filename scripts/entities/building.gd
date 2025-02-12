class_name Building
extends Node2D

@onready var entry := $Entry as Marker2D
@onready var title_label := %TitleLabel as  RichTextLabel
@onready var enter_label := %EnterLabel as RichTextLabel
@onready var flag := %Flag as Node2D
@onready var flagpole := %Flagpole as AudioStreamPlayer2D

@onready var interaction := $Entry/Interaction as Area2D
var interactive := false
var played := false

signal on_activate

func _ready() -> void:
	Global.set_inactive(enter_label)

func _input(_event: InputEvent) -> void:
	if not played and interactive and Input.is_key_pressed(KEY_SPACE):
		played = true
		Global.set_inactive(enter_label)
		on_activate.emit()

func _on_interaction_area_entered(_area: Area2D) -> void:
	Global.set_active(enter_label)
	interactive = true


func _on_interaction_area_exited(_area: Area2D) -> void:
	Global.set_inactive(enter_label)
	interactive = false

func raise_flag() -> void:
	if flag:
		flag.raise()
