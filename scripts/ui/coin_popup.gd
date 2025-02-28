class_name CoinPopup
extends Control

@onready var coin_label := %CoinLabel as RichTextLabel

func _ready() -> void:
	Game.on_coins_changed.connect(_coins_changed)

func _coins_changed(coins: int) -> void:
	var text = Global.wrap_center(str(coins))
	coin_label.text = text
