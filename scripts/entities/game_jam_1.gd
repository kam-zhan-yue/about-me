class_name GameJam1
extends Node2D

@onready var one_last_drink := $Level/BlockHolder/OneLastDrink as QuestionBlock
@onready var upbeet := $Level/BlockHolder/Upbeet as QuestionBlock
@onready var sleepwalker := $Level/BlockHolder/Sleepwalker as QuestionBlock

const TOTAL = 3
var hits := 0

signal on_complete

func _ready() -> void:
	one_last_drink.hit.connect(_one_last_drink)
	upbeet.hit.connect(_upbeet)
	sleepwalker.hit.connect(_sleepwalker)
	
func _one_last_drink() -> void:
	Achievements.activate(Achievements.Achievement.ONE_LAST_DRINK)
	check_complete()

func _upbeet() -> void:
	Achievements.activate(Achievements.Achievement.UPBEET)
	check_complete()

func _sleepwalker() -> void:
	Achievements.activate(Achievements.Achievement.SLEEPWALKER)
	check_complete()

func check_complete() -> void:
	hits += 1
	if hits >= TOTAL:
		on_complete.emit()
