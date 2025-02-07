class_name Firewall
extends Node2D

var fires: Array[AnimatedSprite2D] = []

func _ready() -> void:
	for child in get_children():
		fires.push_back(child as AnimatedSprite2D)
	
	for fire in fires:
		fire.play()
