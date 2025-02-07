class_name AchievementData
extends Resource

enum Tag {
	Unity,
	CSharp,
	Godot,
	GodotScript,
	Bevy,
	Rust,
	React,
	Typescript,
	Javascript,
	Django,
	Python,
	Spring,
	Java,
}

@export var title := ""
@export var tag: Array[Tag] = []
@export var pages: Array[PageData] = []
