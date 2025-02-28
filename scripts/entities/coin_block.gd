class_name CoinBlock
extends Node2D

@onready var coin_sprite := %CoinSprite as AnimatedSprite2D
@onready var question_block := %QuestionBlock as QuestionBlock
@onready var coin := %Coin as AudioStreamPlayer2D

const ANIMATE_Y := 50.0
const ANIMATE_TIME := 0.4

func _ready() -> void:
	question_block.pre_hit.connect(_hit)
	coin_sprite.modulate = Global.CLEAR

func _hit() -> void:
	coin.play()
	question_block.pre_hit.disconnect(_hit)
	Game.add_coins(1)
	coin_sprite.play()
	coin_sprite.modulate = Global.WHITE
	var tween = get_tree().create_tween()
	tween.tween_property(coin_sprite, "global_position", coin_sprite.global_position + Vector2.UP * ANIMATE_Y, ANIMATE_TIME)
	tween.tween_property(coin_sprite, "global_position", coin_sprite.global_position, ANIMATE_TIME)
	tween.tween_callback(_end)

func _end() -> void:
	coin_sprite.modulate = Global.CLEAR
