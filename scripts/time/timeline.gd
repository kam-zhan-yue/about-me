class_name Timeline
extends Node2D

@onready var zone_1 := %"Zone 1" as Timezone
@onready var zone_2 := %"Zone 2" as Timezone
@onready var zone_3 := %"Zone 3" as Timezone
@onready var zone_4 := %"Zone 4" as Timezone
@onready var zone_5 := %"Zone 5" as Timezone

@onready var school := %School as Building
@onready var kurechii := %Kurechii as Building
@onready var unimelb_1 := %"Unimelb 1" as Building
@onready var game_jam_1 := %"Game Jam 1" as GameJam1
@onready var kyodai := %Kyodai as Building
@onready var scs := %SCS as Building
@onready var unimelb_2 := %"Unimelb 2" as Building
@onready var game_jam_2 := %"Game Jam 2" as GameJam2
@onready var flagpole_jump := %FlagpoleJump as Marker2D
@onready var final := %Final as Building
@onready var entry := %Entry as Node2D
@onready var firewall := %Firewall as Firewall
@onready var firezone := %Firezone as Firezone
@onready var bowser_level := %BowserLevel as BowserLevel
@onready var bowser_start := %BowserStart as Marker2D
@onready var bowser_center := %BowserCenter as Marker2D
@onready var game_end := %GameEnd as GameEnd

const SETTINGS = preload("res://resources/game_settings.tres") as GameSettings

var timeline_dict = {}

func _ready() -> void:
	zone_1.activated = true
	school.on_activate.connect(_school)
	kurechii.on_activate.connect(_kurechii)
	unimelb_1.on_activate.connect(_unimelb_1)
	kyodai.on_activate.connect(_kyodai)
	scs.on_activate.connect(_scs)
	unimelb_2.on_activate.connect(_unimelb_2)
	final.on_activate.connect(_final)

	firezone.on_complete.connect(_firezone)
	game_jam_1.on_complete.connect(_game_jam_1)
	game_jam_2.on_complete.connect(_game_jam_2)
	bowser_level.on_complete.connect(_bowser_level)
	game_end.on_complete.connect(_end_game)
	
	Achievements.on_event_completed.connect(_on_event_complete)
	
	timeline_dict = {
		Achievements.Event.SCHOOL: school,
		Achievements.Event.KURECHII: kurechii,
		Achievements.Event.UNIMELB_1: unimelb_1,
		Achievements.Event.GAME_JAM_1: game_jam_1,
		Achievements.Event.KYODAI: kyodai,
		Achievements.Event.SCS: scs,
		Achievements.Event.UNIMELB_2: unimelb_2,
		Achievements.Event.FLAGPOLE: flagpole_jump,
		Achievements.Event.WORLD_1_1_END: final,
		Achievements.Event.GAME_JAM_2: game_jam_2,
		Achievements.Event.BOWSER: bowser_center,
	}

	if SETTINGS.start_event != Achievements.Event.NONE:
		for event in Achievements.Event.values():
			if SETTINGS.start_event == event:
				var location = timeline_dict.get(SETTINGS.start_event)
				if location:
					if event == Achievements.Event.FLAGPOLE:
						Game.player.global_position = location.global_position
					elif event == Achievements.Event.BOWSER:
						Game.player.global_position = bowser_start.global_position
					else:
						Game.player.global_position.x = location.global_position.x
				break
			else:
				Achievements.complete_event(event)

func get_bound() -> float:
	for event in timeline_dict:
		if not Achievements.has_completed(event):
			# Ignore the flagpole
			if event == Achievements.Event.FLAGPOLE:
				continue
			if timeline_dict.get(event):
				return timeline_dict[event].global_position.x
	return 10000

func _school() -> void:
	Achievements.activate_event(Achievements.Event.SCHOOL)

func _kurechii() -> void:
	Achievements.activate_event(Achievements.Event.KURECHII)

func _unimelb_1() -> void:
	Achievements.activate_event(Achievements.Event.UNIMELB_1)

func _kyodai() -> void:
	Achievements.activate_event(Achievements.Event.KYODAI)

func _scs() -> void:
	Achievements.activate_event(Achievements.Event.SCS)

func _unimelb_2() -> void:
	Achievements.activate_event(Achievements.Event.UNIMELB_2)

func _game_jam_1() -> void:
	Achievements.complete_event(Achievements.Event.GAME_JAM_1)

func _game_jam_2() -> void:
	Achievements.complete_event(Achievements.Event.GAME_JAM_2)

func _final() -> void:
	Achievements.complete_event(Achievements.Event.WORLD_1_1_END)
	await Game.player.fade_out()
	await Game.transition_in()
	Game.set_world("8-4")
	Game.player.global_position.x = entry.global_position.x
	await Global.wait(0.3)
	Game.audio.stop()
	Game.transition_out()
	# Necessary to set interactive back to false
	Game.audio.play_world_8_4_start()
	await Game.player.fade_in()
	world_8_4()

func _firezone() -> void:
	pass

func _end_game() -> void:
	Game.end_game()

func _bowser_level() -> void:
	Achievements.complete_event(Achievements.Event.BOWSER)
	Game.camera.lerp_to_pos(game_end.global_position, 3.0)
	Game.audio.play_princess()

func _on_event_complete(event: Achievements.Event) -> void:
	if event == Achievements.Event.SCHOOL:
		school.raise_flag()
		zone_2.activated = true
	elif event == Achievements.Event.KURECHII:
		kurechii.raise_flag()
		zone_3.activated = true
	elif event == Achievements.Event.UNIMELB_1:
		unimelb_1.raise_flag()
		zone_4.activated = true
	elif event == Achievements.Event.SCS:
		scs.raise_flag()
	elif event == Achievements.Event.KYODAI:
		kyodai.raise_flag()
	elif event == Achievements.Event.UNIMELB_2:
		unimelb_2.raise_flag()
		zone_5.activated = true

func world_8_4() -> void:
	Game.set_world("8-4")
	Game.player.interactive = false
	await firezone.activate()
	Game.player.interactive = true
