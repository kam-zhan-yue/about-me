class_name GameJam2
extends Node2D

@onready var tide := %TIDE as QuestionBlock
@onready var re_collect := %RECollect as QuestionBlock

const TOTAL = 2
var hits := 0

signal on_complete

func _ready() -> void:
	tide.hit.connect(_tide)
	re_collect.hit.connect(_re_collect)

func _tide() -> void:
	Achievements.activate(Achievements.Achievement.TIDE)
	check_complete()

func _re_collect() -> void:
	Achievements.activate(Achievements.Achievement.RE_COLLECT)
	check_complete()

func check_complete() -> void:
	hits += 1
	if hits == TOTAL:
		on_complete.emit()
