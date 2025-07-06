extends Node

# Dictionary containing scene keys mapped to their paths
var scene_paths: Dictionary = {
	"Start_screen": "res://Menus/Start_screen.tscn",
	"Loading_screen":"res://Menus/Loading_screen.tscn",
	"Settings": "res://Menus/Start_screen.tscn",
	"Level_selection_screen":"res://Menus/Level_selection_screen.tscn",
	"Test_level": "res://scenes/levels/Test_evel.tscn"
}

func get_scene_path(scene_identifier: String) -> String:
	if scene_paths.has(scene_identifier):
		return scene_paths[scene_identifier]
	else:
		return scene_identifier

func level_exists(scene_identifier: String) -> bool:
	if scene_paths.has(scene_identifier):
		return true
	else:
		return ResourceLoader.exists(scene_identifier)
