class_name Player
extends CharacterBody2D
 
@onready var sprite := $Sprite as AnimatedSprite2D
@onready var jump := %Jump as AudioStreamPlayer2D
@onready var sfx_flagpole := %Flagpole as AudioStreamPlayer2D

const SPEED = 175.0
const JUMP_VELOCITY = -350.0
const BOUNCE_VELOCITY = -200.0
const PLAYER_WIDTH = 18.0

var interactive = true
var facing_right = true
var active = true

func _ready() -> void:
	sprite.play("idle")

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	if not interactive or not active:
		return

	# Handle jump.
	if Input.is_action_just_pressed("move_jump") and is_on_floor():
		_jump(JUMP_VELOCITY)

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("move_left", "move_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	# Check if can move left
	if velocity.x < 0 and not Game.in_left_bounds(position.x - PLAYER_WIDTH / 2):
		velocity.x = 0
	# Check if can move right
	if velocity.x > 0 and not Game.in_right_bounds(position.x + PLAYER_WIDTH / 2):
		velocity.x = 0
	animate_player()
	move_and_slide()

func _jump(jump_force: float) -> void:
	velocity.y = JUMP_VELOCITY
	jump.play()
	sprite.play("jump_start")
	
func bounce() -> void:
	velocity.y = BOUNCE_VELOCITY
	sprite.play("jump_start")
	

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
	await Global.fade_in(self.sprite)
	interactive = true
	self.collision_layer = 1
	self.collision_mask = 1

func fade_out():
	interactive = false
	self.collision_layer = 2
	self.collision_mask = 2
	await Global.fade_out(self.sprite)

func flagpole(target: Vector2):
	sfx_flagpole.play()
	sprite.play("jump_fall")
	interactive = false
	var time = (target.y - position.y) / Flagpole.FLAG_FALL_SPEED
	if time < 0:
		time = 0
	var next_pos = Vector2(position.x,  target.y)
	var tween = get_tree().create_tween()
	tween.tween_property(self, "position", next_pos, time)
	tween.tween_callback(_end_flagpole)

func _end_flagpole():
	interactive = true
