class_name DatePopup
extends Control

@onready var date_label := %RichTextLabel as RichTextLabel

func _ready() -> void:
	Game.on_date_changed.connect(_on_date_changed)

func _on_date_changed(new_date: Date) -> void:
	var outline_str = str('[outline_size=32]', new_date.to_string(), '[/outline_size]')
	date_label.text = outline_str
  
