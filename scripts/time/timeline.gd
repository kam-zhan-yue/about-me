class_name Timeline
extends Node2D

@onready var zone_1 := $"Zone 1" as Timezone
@onready var zone_2 := $"Zone 2" as Timezone
@onready var zone_3 := $"Zone 3" as Timezone
@onready var zone_4 := $"Zone 4" as Timezone
@onready var zone_5 := $"Zone 5" as Timezone

@onready var school := %School as Building
@onready var kurechii := %Kurechii as Building
@onready var unimelb_1 := %"Unimelb 1" as Building
@onready var game_jam_1 := %"Game Jam 1" as GameJam1
@onready var kyodai := %Kyodai as Building
@onready var scs := %SCS as Building
@onready var unimelb_2 := %"Unimelb 2" as Building
@onready var game_jam_2 := %"Game Jam 2" as GameJam2
@onready var final_point := $FinalPoint as Marker2D

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
	
	game_jam_1.on_complete.connect(_game_jam_1)
	game_jam_2.on_complete.connect(_game_jam_2)
	
	Achievements.on_event_completed.connect(_on_event_complete)
	
	timeline_dict = {
		Achievements.Event.SCHOOL: school,
		Achievements.Event.KURECHII: kurechii,
		Achievements.Event.GAME_JAM_1: game_jam_1,
		Achievements.Event.UNIMELB_1: unimelb_1,
		Achievements.Event.KYODAI: kyodai,
		Achievements.Event.SCS: scs,
		Achievements.Event.UNIMELB_2: unimelb_2,
		Achievements.Event.GAME_JAM_2: game_jam_2,
	}

	if SETTINGS.start_event != Achievements.Event.NONE:
		for event in Achievements.Event.values():
			if SETTINGS.start_event == event:
				var location = timeline_dict.get(SETTINGS.start_event)
				if location:
					Game.player.global_position.x = location.global_position.x
				break
			else:
				Achievements.complete_event(event)

func get_bound() -> float:
	for event in timeline_dict:
		if not Achievements.has_completed(event):
			if timeline_dict.get(event):
				return timeline_dict[event].global_position.x
	return final_point.global_position.x

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


func _on_event_complete(event: Achievements.Event) -> void:
	if event == Achievements.Event.SCHOOL:
		zone_2.activated = true
	elif event == Achievements.Event.KURECHII:
		zone_3.activated = true
	elif event == Achievements.Event.UNIMELB_1:
		zone_4.activated = true
	elif event == Achievements.Event.UNIMELB_2:
		zone_5.activated = true
