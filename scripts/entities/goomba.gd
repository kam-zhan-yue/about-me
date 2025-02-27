class_name Goomba
extends CharacterBody2D

@onready var animated_sprite_2d := %AnimatedSprite2D as AnimatedSprite2D
@onready var rigidbody := %RigidBody2D as RigidBody2D
@onready var left_ray := %LeftRay as RayCast2D
@onready var right_ray := %RightRay as RayCast2D

var speed := 0.0
var rotation_speed := 0.0
const SPEED = 10.0
const DESPAWN_TIME = 0.5
const LAUNCH_SPEED_X = 200.0
const LAUNCH_SPEED_Y = 400.0
const ROTATION_SPEED = 50.0
var state := State.ACTIVE

enum State {
	ACTIVE,
	LAUNCHING,
	DEAD
}

func _ready() -> void:
	animated_sprite_2d.play()
	self.speed = -SPEED

func _physics_process(delta: float) -> void:
	if state == State.DEAD: return
	if state == State.LAUNCHING:
		if not is_on_floor():
			velocity += get_gravity() * delta
		rotation += rotation_speed * delta
		move_and_slide()
		return
		
	if self.speed > 0 and right_ray.is_colliding():
		self.speed = -SPEED
	elif self.speed < 0 and left_ray.is_colliding():
		self.speed = SPEED
	self.velocity = Vector2(self.speed, 0.0)
	
	# Check if touching player
	if right_ray.get_collider() is Player:
		launch(Vector2.LEFT)
	elif left_ray.get_collider() is Player:
		launch(Vector2.RIGHT)

	move_and_slide()

func _on_stomp_area_body_entered(body: Node2D) -> void:
	if state == State.DEAD: return
	if body is Player:
		print("Bounce")
		body.bounce()
		stomped()

func stomped() -> void:
	animated_sprite_2d.play('dead')
	die()

func launch(direction: Vector2) -> void:
	if state == State.DEAD: return
	var launch_force = direction * LAUNCH_SPEED_X
	rotation_speed = direction.x * ROTATION_SPEED
	launch_force.y = -LAUNCH_SPEED_Y
	self.velocity = launch_force
	self.state = State.LAUNCHING
	self.collision_layer = 2
	self.collision_mask = 2
	await Global.wait(10.0)
	die()

func die() -> void:
	self.state = State.DEAD
	self.collision_layer = 2
	self.collision_mask = 2
	self.speed = 0.0
	Global.fade(self, DESPAWN_TIME, false)
	await Global.wait(DESPAWN_TIME)
	queue_free()


func _on_body_entered(body: Node) -> void:
	print("Body Entered")
