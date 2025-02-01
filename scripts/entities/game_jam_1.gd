class_name GameJam1
extends Node2D

@onready var one_last_drink := $Level/BlockHolder/OneLastDrink as QuestionBlock
@onready var greenpath := $Level/BlockHolder/Greenpath as QuestionBlock

const TOTAL = 2
var hits := 0

signal on_complete

func _ready() -> void:
	one_last_drink.hit.connect(_one_last_drink)
	greenpath.hit.connect(_greenpath)
	
func _one_last_drink() -> void:
	Achievements.activate(Achievements.Achievement.ONE_LAST_DRINK)
	check_complete()

func _greenpath() -> void:
	Achievements.activate(Achievements.Achievement.GREENPATH)
	check_complete()

func check_complete() -> void:
	hits += 1
	if hits >= TOTAL:
		on_complete.emit()
