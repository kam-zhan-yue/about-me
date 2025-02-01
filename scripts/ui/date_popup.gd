class_name DatePopup
extends Control

@onready var date_label := %DateLabel as RichTextLabel

func init() -> void:
	Game.on_date_changed.connect(_on_date_changed)
	
func _on_date_changed(new_date: Date) -> void:
	date_label.text = Global.wrap_center(new_date.to_string())
  
