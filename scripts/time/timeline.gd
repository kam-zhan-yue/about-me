class_name Timeline
extends Node2D

@onready var school := %School as Building
@onready var kurechii := %Kurechii as Building
@onready var game_jam_1 := %"Game Jam 1" as Node2D
@onready var unimelb_1 := %"Unimelb 1" as Building

var timeline_dict = {}

func _ready() -> void:
	school.on_activate.connect(_school)
	timeline_dict = {
		Achievements.Event.SCHOOL: school,
		Achievements.Event.KURECHII: kurechii,
		Achievements.Event.GAME_JAM_1: game_jam_1,
		Achievements.Event.MELBOURNE_UNI_1: unimelb_1,
	}

func _school() -> void:
	Achievements.activate_event(Achievements.Event.SCHOOL)

func get_bound() -> float:
	for event in timeline_dict:
		if not Achievements.has_completed(event):
			if timeline_dict.get(event):
				return timeline_dict[event].global_position.x
	return 10000
