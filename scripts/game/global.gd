extends Node

var WHITE = Color(1.0, 1.0, 1.0, 1.0)
var CLEAR = Color(1.0, 1.0, 1.0, 0.0)
var FADE_TIME = 0.5

var zoom := 5.0

func seconds(time: float) -> void:
	await get_tree().create_timer(time).timeout
	
func frame() -> void:
	var delta := get_process_delta_time()
	await get_tree().create_timer(delta).timeout

func wait_fade() -> void:
	await get_tree().create_timer(FADE_TIME).timeout

func set_active(node: Node) -> void:
	active(node, true)
	
func set_inactive(node: Node) -> void:
	active(node, false)

func to_blue() -> Vector2:
	return Vector2(-1.0, 0.5).normalized()

func to_red() -> Vector2:
	return Vector2(1.0, -0.5).normalized()

func active(node: Node, is_active: bool) -> void:
	# Set visibility
	node.visible = is_active
	
	# Set general processing
	node.set_process(is_active)
	
	# Set physics processing
	node.set_physics_process(is_active)
	
	# Optionally, set input processing if needed
	if node.has_method("set_process_input"):
		node.set_process_input(is_active)
	
	# Optionally, set unhandled input processing if needed
	if node.has_method("set_process_unhandled_input"):
		node.set_process_unhandled_input(is_active)

func ease_out_quart(x: float) -> float:
	return 1 - pow(1 - x, 4)

func ease_out_sin(x: float) -> float:
	return sin((x * PI) / 2);

func flip_v(rotation: float) -> bool:
	var left_rotate = rotation > -PI*1.5 and rotation <-PI*0.5
	var right_rotate = rotation > PI*0.5 and rotation < PI*1.5
	return left_rotate or right_rotate

func from_months(total_months: int) -> Date:
	var years := total_months / 12
	var months := total_months % 12
	if months == 0:
		months =  1
	return Date.new(years, months)

func wrap_center(text: String) -> String:
	return str("[center]", text, "[/center]")

func wrap_outline(text: String, size: float) -> String:
	return str("[outline_size=", size, "]", text, "[/outline_size]")

func fade_in(node: Node) -> void:
	var tween = get_tree().create_tween()
	tween.tween_property(node, "modulate", WHITE, FADE_TIME)
	await wait_fade()
	
func fade_out(node: Node) -> void:
	var tween = get_tree().create_tween()
	tween.tween_property(node, "modulate", CLEAR, FADE_TIME)
	await wait_fade()
