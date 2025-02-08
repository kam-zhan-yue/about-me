class_name Firewall
extends Node2D

var fires: Array[AnimatedSprite2D] = []
const INTERVAL = 0.05

func _ready() -> void:
	for child in get_children():
		fires.push_back(child as AnimatedSprite2D)
	for fire in fires:
		Global.set_inactive(fire)

func activate() -> void:
	print("Active")
	for fire in fires:
		Global.set_active(fire)
		await Global.wait(INTERVAL)
	
	for fire in fires:
		fire.play()
