class_name GameJam2
extends Node2D


@onready var first_round: Node2D = %FirstRound
@onready var second_round: Node2D = %SecondRound
@onready var the_shackled := %"The Shackled" as QuestionBlock
@onready var beans_for_good := %"Beans for Good" as QuestionBlock
@onready var tide := %TIDE as QuestionBlock
@onready var re_collect := %RECollect as QuestionBlock
@onready var hundred_little_guys := %"Hundred Little Guys" as QuestionBlock
@onready var swirly_whirly := %"Swirly Whirly" as QuestionBlock

const FIRST_ROUND = 3
const SECOND_ROUND = 6
const SCALE_UP = Vector2(1.2, 1.2)
const TWEEN_TIME = 0.5
var hits := 0

signal on_complete

func _ready() -> void:
	re_collect.scale = Vector2.ZERO
	hundred_little_guys.scale = Vector2.ZERO
	swirly_whirly.scale = Vector2.ZERO
	Global.set_inactive(second_round)
	Global.set_active(first_round)
	the_shackled.hit.connect(_the_shackled)
	beans_for_good.hit.connect(_beans_for_good)
	tide.hit.connect(_tide)
	re_collect.hit.connect(_re_collect)
	hundred_little_guys.hit.connect(_hundred_little_guys)
	swirly_whirly.hit.connect(_swirly_whirly)

func _the_shackled() -> void:
	Achievements.activate(Achievements.Achievement.THE_SHACKLED)
	check_complete()

func _beans_for_good() -> void:
	print("BEANS")
	Achievements.activate(Achievements.Achievement.BEANS_FOR_GOOD)
	check_complete()

func _tide() -> void:
	Achievements.activate(Achievements.Achievement.TIDE)
	check_complete()

func _re_collect() -> void:
	Achievements.activate(Achievements.Achievement.RE_COLLECT)
	check_complete()

func _hundred_little_guys() -> void:
	print("MICE")
	Achievements.activate(Achievements.Achievement.HUNDRED_LITTLE_GUYS)
	check_complete()

func _swirly_whirly() -> void:
	Achievements.activate(Achievements.Achievement.SWIRLY_WHIRLY)
	check_complete()

func check_complete() -> void:
	hits += 1
	if hits == FIRST_ROUND:
		next_round_sequence()
	elif hits == SECOND_ROUND:
		on_complete.emit()

func next_round_sequence() -> void:
	var tween = get_tree().create_tween()
	tween.tween_property(the_shackled, "scale", SCALE_UP, TWEEN_TIME).set_trans(Tween.TRANS_QUART)
	tween.set_parallel().parallel().tween_property(beans_for_good, "scale", SCALE_UP, TWEEN_TIME).set_trans(Tween.TRANS_QUART)
	tween.set_parallel().parallel().tween_property(tide, "scale", SCALE_UP, TWEEN_TIME).set_trans(Tween.TRANS_QUART)
	
	tween.tween_property(the_shackled, "scale", Vector2.ZERO, TWEEN_TIME).set_trans(Tween.TRANS_QUART)
	tween.set_parallel().parallel().tween_property(beans_for_good, "scale", Vector2.ZERO, TWEEN_TIME).set_trans(Tween.TRANS_QUART)
	tween.set_parallel().parallel().tween_property(tide, "scale", Vector2.ZERO, TWEEN_TIME).set_trans(Tween.TRANS_QUART)
	tween.tween_callback(_activate_next_round)

	tween.tween_property(re_collect, "scale", Vector2.ONE, TWEEN_TIME).set_trans(Tween.TRANS_QUART)
	tween.set_parallel().parallel().tween_property(hundred_little_guys, "scale", Vector2.ONE, TWEEN_TIME).set_trans(Tween.TRANS_QUART)
	tween.set_parallel().parallel().tween_property(swirly_whirly, "scale", Vector2.ONE, TWEEN_TIME).set_trans(Tween.TRANS_QUART)

func _activate_next_round() -> void:
	Global.set_active(second_round)
	Global.set_inactive(first_round)
