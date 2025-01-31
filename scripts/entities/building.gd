class_name Building
extends Node2D

@export var title := "Building"
@onready var entry := $Entry as Marker2D

@onready var interaction := $Entry/Interaction as Area2D
var interactive := true
var played := false

signal show
signal hide

func _ready() -> void:
	interaction.body_entered.connect(on_enter)
	interaction.body_exited.connect(on_exit)


func on_enter(_body: Node2D) -> void:
	show.emit()
	interactive = true
	pass

func on_exit(_body: Node2D) -> void:
	hide.emit()
	interactive = true
	pass
