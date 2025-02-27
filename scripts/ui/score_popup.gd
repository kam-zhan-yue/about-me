class_name ScorePopup
extends Control

@onready var score_label := %ScoreLabel as RichTextLabel

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Game.on_points_changed.connect(_score)

func _score(points: int) -> void:
	var text = Global.wrap_center(str(points))
	score_label.text = text
