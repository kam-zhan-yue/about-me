class_name GameJam2
extends Node2D

@onready var graphics := %Graphics as QuestionBlock
@onready var multi := %Multiplayer as QuestionBlock

const TOTAL = 2
var hits := 0

signal on_complete

func _ready() -> void:
	graphics.hit.connect(_graphics)
	multi.hit.connect(_multiplayer)

func _graphics() -> void:
	Achievements.activate(Achievements.Achievement.GRAPHICS)
	check_complete()

func _multiplayer() -> void:
	Achievements.activate(Achievements.Achievement.MULTIPLAYER)
	check_complete()

func check_complete() -> void:
	hits += 1
	if hits == TOTAL:
		on_complete.emit()
