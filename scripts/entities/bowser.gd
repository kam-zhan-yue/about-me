class_name Bowser
extends CharacterBody2D

@onready var sprite := %AnimatedSprite2D as AnimatedSprite2D

const FIREBALL = preload("res://scenes/bowser_fireball.tscn")

var active := false

const JUMP_INTERVAL = 1.5
const SPEED = 20.0
const JUMP_VELOCITY = -250.0

func start() -> void:
	self.active = true
	self.sprite.play()
	self.jump_routine()
	self.move_routine()
	self.attack_routine()

func stop() -> void:
	self.active = false
	self.sprite.stop()
	self.velocity.x = 0
	print("Stopping")
	Game.clear_projectiles()

func _physics_process(delta: float) -> void:
	if not self.active: return

	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	move_and_slide()

func jump_routine() -> void:
	await Global.wait(JUMP_INTERVAL)
	while self.active:
		if is_on_floor():
			velocity.y = JUMP_VELOCITY	
		await Global.wait(JUMP_INTERVAL)

func move_routine() -> void:
	await Global.wait(1.0)
	while self.active:
		if velocity.x < 0:
			velocity.x = SPEED
		else:
			velocity.x = -SPEED
		await Global.wait(1.0)

func attack_routine() -> void:
	while self.active:
		shoot_fireball()
		await Global.wait(1.0)

func shoot_fireball() -> void:
	var fireball = FIREBALL.instantiate()
	get_parent().add_child(fireball)
	Game.add_projectile(fireball)
