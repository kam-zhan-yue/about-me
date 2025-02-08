class_name Firewall
extends Node2D

var fires: Array[AnimatedSprite2D] = []
const INTERVAL = 0.05
const FLAMES_TO_REDUCE = 3

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
	self.fires.reverse()
	for fire in self.fires:
		fire.stop()

	for fire in self.fires:
		Global.set_inactive(fire)
		await Global.wait(INTERVAL)


func reduce_flames() -> void:
	var fire_len = len(self.fires)
	for i in range(FLAMES_TO_REDUCE):
		var index = fire_len - i - 1
		Global.set_inactive(self.fires[index])
		await Global.wait(INTERVAL)
		self.fires.remove_at(index)
