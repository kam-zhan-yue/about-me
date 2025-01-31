class_name Timezone
extends Node2D

var dates: Array[DateMark] = []

func _ready() -> void:
	var children = get_children()
	for child in children:
		var child_name = child.get_name()
		var split := child_name.split('-')
		var year := int(split[0])
		var month := int(split[1])
		dates.push_back(DateMark.new(Date.new(year, month), child.global_position))

func _process(_delta: float) -> void:
	var player_x := Game.player.position.x
	if player_x <= dates[-1].pos.x:
		for i in range(len(dates) - 1):
			if player_x > dates[i].pos.x and player_x < dates[i + 1].pos.x:
				update_player_date(dates[i], dates[i + 1])


func update_player_date(left: DateMark, right: DateMark) -> void:
	var value = (Game.player.position.x - left.pos.x) / (right.pos.x - left.pos.x)
	var new_date := left.date.lerp_date(right.date, value)
	Game.update_date(new_date)
