extends Node

# Dictionary containing scene keys mapped to their paths
var scene_paths: Dictionary = {
	"start_screen": "res://Menus/start_screen.tscn",
	"loading_screen":"res://Menus/loading_screen.tscn",
	"test_level": "res://scenes/levels/test_evel.tscn",
#	"game_over": "res://scenes/ui/GameOver.tscn",
#	"credits": "res://scenes/ui/Credits.tscn",
#	"settings": "res://scenes/ui/Settings.tscn"
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
