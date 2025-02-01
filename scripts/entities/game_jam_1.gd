class_name GameJam1
extends Node2D

@onready var one_last_drink := $Level/BlockHolder/OneLastDrink as QuestionBlock
@onready var upbeet := $Level/BlockHolder/Upbeet as QuestionBlock

const TOTAL = 2
var hits := 0

signal on_complete

func _ready() -> void:
	one_last_drink.hit.connect(_one_last_drink)
	upbeet.hit.connect(_upbeet)
	
func _one_last_drink() -> void:
	Achievements.activate(Achievements.Achievement.ONE_LAST_DRINK)
	check_complete()

func _upbeet() -> void:
	Achievements.activate(Achievements.Achievement.UPBEET)
	check_complete()

func check_complete() -> void:
	hits += 1
	if hits >= TOTAL:
		on_complete.emit()
