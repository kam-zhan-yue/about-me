class_name Player
extends CharacterBody2D
 
@onready var sprite := $Sprite as AnimatedSprite2D

const FADE_TIME = 1.2
const SPEED = 175.0
const JUMP_VELOCITY = -300.0
const PLAYER_WIDTH = 18.0

var interactive = true
var facing_right = true

func _ready() -> void:
	sprite.play("idle")

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	if not interactive:
		return

	# Handle jump.
	if Input.is_action_just_pressed("move_jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		sprite.play("jump_start")

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("move_left", "move_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	# Check if can move left
	if velocity.x < 0 and not Game.in_bounds(position.x - PLAYER_WIDTH / 2):
		velocity.x = 0
	animate_player()
	move_and_slide()

func animate_player() -> void:
	if facing_right and velocity.x < 0:
		facing_right = false
		sprite.flip_h = true
	elif not facing_right and velocity.x > 0:
		facing_right = true
		sprite.flip_h = false
	
	if not is_on_floor() and velocity.y > 0:
		sprite.play("jump_fall")
	elif is_on_floor() and not velocity.y < 0:
		var walking = velocity.length() > 0
		sprite.play("walk" if walking else "idle")

func fade_in():
	sprite.modulate.a = 0.0
	var timer := 0.0
	while timer < FADE_TIME:
		timer += get_process_delta_time()
		var t := timer / FADE_TIME
		sprite.modulate.a = t
		await Global.frame()
	interactive = true

func fade_out():
	interactive = false
	sprite.modulate.a = 1.0
	var timer := 0.0
	while timer < FADE_TIME:
		timer += get_process_delta_time()
		var t := timer / FADE_TIME
		sprite.modulate.a = 1-t
		await Global.frame()
	sprite.modulate.a = 0.0
