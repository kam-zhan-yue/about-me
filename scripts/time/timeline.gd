class_name Timeline
extends Node2D

@onready var school := %School as Building
@onready var kurechii := %Kurechii as Building
@onready var game_jam_1 := %"Game Jam 1" as Node2D
@onready var unimelb_1 := %"Unimelb 1" as Building

const SETTINGS = preload("res://resources/game_settings.tres") as GameSettings

var timeline_dict = {}

func _ready() -> void:
	school.on_activate.connect(_school)
	kurechii.on_activate.connect(_kurechii)
	unimelb_1.on_activate.connect(_unimelb_1)
	timeline_dict = {
		Achievements.Event.SCHOOL: school,
		Achievements.Event.KURECHII: kurechii,
		Achievements.Event.GAME_JAM_1: game_jam_1,
		Achievements.Event.UNIMELB_1: unimelb_1,
	}

		
	if SETTINGS.start_event != Achievements.Event.NONE:
		for event in Achievements.Event.values():
			if SETTINGS.start_event == event:
				var location = timeline_dict.get(SETTINGS.start_event)
				if location:
					Game.player.global_position.x = location.global_position.x
			else:
				Achievements.completed_events[event] = true

func get_bound() -> float:
	for event in timeline_dict:
		if not Achievements.has_completed(event):
			if timeline_dict.get(event):
				return timeline_dict[event].global_position.x
	return 10000

func _school() -> void:
	Achievements.activate_event(Achievements.Event.SCHOOL)
	
func _kurechii() -> void:
	Achievements.activate_event(Achievements.Event.KURECHII)
	
func _unimelb_1() -> void:
	Achievements.activate_event(Achievements.Event.UNIMELB_1)
