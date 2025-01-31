class_name Camera
extends Camera2D

var player: Player
var x_pos: float = 0

func _ready() -> void:
	x_pos = global_position.x


func _process(delta: float) -> void:
	var player_x := Game.player.global_position.x
	if player_x > x_pos:
		x_pos = player_x
		self.global_position.x = x_pos
		
