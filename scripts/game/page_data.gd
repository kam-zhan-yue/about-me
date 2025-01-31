class_name PageData
extends Resource

enum Media {
	IMAGE,
	VIDEO,
}

@export var media: Media = Media.IMAGE
@export var filename := ""
@export_multiline var description := ""
