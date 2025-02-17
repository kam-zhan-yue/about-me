class_name Camera
extends Camera2D

@onready var timeline := %Timeline as Timeline

enum Mode {
	FollowPlayer,
	ManualControl,
	LerpToPos,
}

var player: Player
var x_pos: float = 0
var mode := Mode.FollowPlayer

func _ready() -> void:
	x_pos = global_position.x


func _process(_delta: float) -> void:
	if mode == Mode.FollowPlayer:
		var player_x := Game.player.global_position.x
		var timeline_bound = timeline.get_bound()
		if self.global_position.x >= timeline_bound:
			self.global_position.x = timeline_bound
		elif player_x > self.global_position.x:
			self.global_position.x = player_x

func set_mode(other: Mode) -> void:
	self.mode = other

func lerp_to_pos(target: Vector2, duration: float) -> void:
	self.set_mode(Mode.LerpToPos)
	var tween = get_tree().create_tween()
	tween.tween_property(self, "global_position", target, duration)
	
