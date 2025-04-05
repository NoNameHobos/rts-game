extends Node

class_name SceneManager

var START_SCENE: String = "res://scenes/levels/test_level.tscn"

var current_scene: Node = null

func load_scene(scene_name: String) -> void:
	if (!scene_name.begins_with("res://")):
		scene_name = "res://" + scene_name
	var new_scene : PackedScene = load(scene_name)
	if (new_scene == null):
		push_error("could not find scene: %s" % scene_name)
		return
	if (current_scene != null):
		remove_child(current_scene)
		current_scene.queue_free()
	current_scene = new_scene.instantiate()
	add_child(current_scene)

func _ready():
	load_scene(START_SCENE)
