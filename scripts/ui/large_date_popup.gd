class_name LargeDatePopup
extends Control

@onready var date_label := %DateLabel as RichTextLabel

func init() -> void:
	self.modulate.a = 0.0
	Game.on_date_changed.connect(_on_date_changed)

func _on_date_changed(date: Date) -> void:
	var center = Global.wrap_center(date.to_string())
	var outline = Global.wrap_outline(center, 12)
	date_label.text = outline
