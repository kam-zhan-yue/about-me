class_name Firezone
extends Node2D

@onready var firewall := %Firewall as Firewall
@onready var fire_start := %FireStart as Marker2D
@onready var fire_end := %FireEnd as Marker2D

@onready var hundred_little_guys := %HundredLittleGuys as QuestionBlock
@onready var upbeet := %Upbeet as QuestionBlock
@onready var sleepwalker := %Sleepwalker as QuestionBlock
@onready var swirly_whirly := %SwirlyWhirly as QuestionBlock

var activated := false
var timer = 0.0
var hits := 0
var can_deactivate := false

signal on_complete

const TOTAL = 4
const TIME_TO_TARGET := 8.0
var original_wall := Vector2.ZERO

func _ready() -> void:
	hundred_little_guys.hit.connect(_hundred_little_guys)
	upbeet.hit.connect(_upbeet)
	sleepwalker.hit.connect(_sleepwalker)
	swirly_whirly.hit.connect(_swirly_whirly)
	Achievements.on_done_showing.connect(_on_done_showing)

func activate() -> void:
	Game.camera.set_mode(Camera.Mode.ManualControl)
	await firewall.activate()
	self.timer = 0.0
	self.original_wall = firewall.global_position
	self.activated = true
	print("Activate")

func _input(_event: InputEvent) -> void:
	if self.firewall.activated and Input.is_action_just_pressed("ui_pause"):
		print("What")
		self.activated = !self.activated

func _process(delta: float) -> void:
	if Game.paused: return
	if not self.activated: return
	var next_pos := fire_start.global_position.lerp(fire_end.global_position, timer / TIME_TO_TARGET)
	Game.camera.global_position.x = next_pos.x
	var displacement := next_pos - fire_start.global_position
	firewall.global_position.x = self.original_wall.x + displacement.x

	timer += delta
	if timer >= TIME_TO_TARGET:
		self.deactivate()

func deactivate() -> void:
	if self.activated:
		self.activated = false
		Game.camera.set_mode(Camera.Mode.FollowPlayer)
		await firewall.deactivate()

func _upbeet() -> void:
	Achievements.activate(Achievements.Achievement.UPBEET)
	check_complete()

func _sleepwalker() -> void:
	Achievements.activate(Achievements.Achievement.SLEEPWALKER)
	check_complete()

func _hundred_little_guys() -> void:
	Achievements.activate(Achievements.Achievement.HUNDRED_LITTLE_GUYS)
	check_complete()

func _swirly_whirly() -> void:
	Achievements.activate(Achievements.Achievement.SWIRLY_WHIRLY)
	check_complete()

func check_complete() -> void:
	hits += 1
	if hits >= TOTAL:
		self.can_deactivate = true

func reduce_flames() -> void:
	await firewall.reduce_flames()

func _on_done_showing() -> void:
	if self.can_deactivate:
		await self.deactivate()
		self.on_complete.emit()
	elif self.activated:
		Game.player.active = false
		self.activated = false
		#await reduce_flames()
		Game.player.active = true
		self.activated = true
