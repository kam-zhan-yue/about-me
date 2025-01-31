class_name Player
extends CharacterBody2D

const SPEED = 175.0
const JUMP_VELOCITY = -300.0
const PLAYER_WIDTH = 18.0

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("move_jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

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
	move_and_slide()
