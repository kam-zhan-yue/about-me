class_name WorldPopup
extends Control
@onready var world_label := %WorldLabel as RichTextLabel

func _ready() -> void:
	Game.on_world_changed.connect(_on_world_changed)

func _on_world_changed(world: String) -> void:
	world_label.text = Global.wrap_center(world)
	
