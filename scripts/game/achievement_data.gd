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
	NodeJS,
	MongoDB,
	Firebase,
	Ink,
	Processing,
}

@export var title := ""
@export var tags: Array[Tag] = []
@export var pages: Array[PageData] = []
