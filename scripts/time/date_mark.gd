class_name DateMark

var date: Date
var pos: Vector2

func _init(d: Date = null, p: Vector2 = Vector2.ZERO) -> void:
	self.date = d
	self.pos = p
