extends Node2D

@onready var one_last_drink := $Level/BlockHolder/OneLastDrink as QuestionBlock
@onready var greenpath := $Level/BlockHolder/Greenpath as QuestionBlock

func _ready() -> void:
	oen_last_drink.hit.connect(_one_last_drink)
	greenpath.hit.connect(_greenpath)
	
func _one_last_drink() -> void:
	Global.activate("ONE_LAST_DRINK")


func _greenpath() -> void:
	pass
