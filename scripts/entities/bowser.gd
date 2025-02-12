class_name Bowser
extends CharacterBody2D

@onready var sprite := %AnimatedSprite2D as AnimatedSprite2D
@onready var fireball_spawn := %FireballSpawn as Marker2D
@onready var fireball := %Fireball as AudioStreamPlayer2D
@onready var sfx_fall := %Fall as AudioStreamPlayer2D

const FIREBALL = preload("res://scenes/bowser_fireball.tscn")

enum State {
	NONE,
	ACTIVE,
	DEFEATED,
	FALL,
}

const FIREBALL_INTERVAL = 2.5
const JUMP_INTERVAL = 1.75
const SPEED = 20.0
const JUMP_VELOCITY = -250.0
var state := State.NONE

func start() -> void:
	self.state = State.ACTIVE
	self.sprite.play()
	self.jump_routine()
	self.move_routine()
	self.attack_routine()

func stop() -> void:
	self.state = State.DEFEATED
	self.sprite.stop()
	self.velocity.x = 0
	self.clear_fireballs()

func fall() -> void:
	sfx_fall.play()
	self.state = State.FALL

func _physics_process(delta: float) -> void:
	if self.state == State.ACTIVE or self.state == State.FALL:
		# Add the gravity.
		if not is_on_floor():
			velocity += get_gravity() * delta
		else:
			sprite.flip_h = is_player_to_right()

		move_and_slide()

func is_player_to_right() -> bool:
	return global_position.x < Game.player.global_position.x

func jump_routine() -> void:
	await Global.wait(JUMP_INTERVAL)
	while self.state == State.ACTIVE:
		if is_on_floor():
			velocity.y = JUMP_VELOCITY	
		await Global.wait(JUMP_INTERVAL)

func move_routine() -> void:
	await Global.wait(1.0)
	while self.state == State.ACTIVE:
		if velocity.x < 0:
			velocity.x = SPEED
		else:
			velocity.x = -SPEED
		await Global.wait(1.0)

func attack_routine() -> void:
	while self.state == State.ACTIVE:
		if not is_player_to_right():
			shoot_fireball()
		await Global.wait(FIREBALL_INTERVAL)

func shoot_fireball() -> void:
	var fireball = FIREBALL.instantiate()
	get_parent().add_child(fireball)
	fireball.global_position = fireball_spawn.global_position

func clear_fireballs() -> void:
	for child in get_parent().get_children():
		if child is BowserFireball:
			child.queue_free()
