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
	for fire in fires:
		Global.set_active(fire)
		await Global.wait(INTERVAL)
	
	for fire in fires:
		fire.play()

func deactivate() -> void:
	fires.reverse()
	for fire in fires:
		fire.stop()

	for fire in fires:
		Global.set_inactive(fire)
		await Global.wait(INTERVAL)
