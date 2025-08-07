extends Node

enum Scene {
	START_SCREEN,
	LOADING_SCREEN,
	SETTINGS,
	CHARACTER_SELECTION_SCREEN,
	GAMEPLAY
}

var scene_paths = {
	Scene.START_SCREEN: "res://Menus/Start_screen.tscn",
	Scene.LOADING_SCREEN: "res://Menus/Loading_screen.tscn",
	Scene.SETTINGS: "res://Menus/Settings.tscn",
	Scene.CHARACTER_SELECTION_SCREEN: "res://Menus/Character_selection_screen.tscn",
	Scene.GAMEPLAY: "res://Gameplay/Gameplay.tscn"
}

var string_to_enum = {
	"Start_screen": Scene.START_SCREEN,
	"Loading_screen": Scene.LOADING_SCREEN,
	"Settings": Scene.SETTINGS,
	"Character_selection_screen": Scene.CHARACTER_SELECTION_SCREEN,
	"Gameplay": Scene.GAMEPLAY
}

var enum_to_string = {
	Scene.START_SCREEN: "Start_screen",
	Scene.LOADING_SCREEN: "Loading_screen",
	Scene.SETTINGS: "Settings",
	Scene.CHARACTER_SELECTION_SCREEN: "Character_selection_screen",
	Scene.GAMEPLAY: "Gameplay"
}

func get_scene_path(scene: Scene) -> String:
	if scene in scene_paths:
		return scene_paths[scene]
	return ""

func get_enum_from_string(scene_name: String) -> Scene:
	if scene_name in string_to_enum:
		return string_to_enum[scene_name]
	return Scene.START_SCREEN  # Default fallback

func get_string_from_enum(scene: Scene) -> String:
	if scene in enum_to_string:
		return enum_to_string[scene]
	return ""

func get_scene_path_from_string(scene_name: String) -> String:
	var scene_enum = get_enum_from_string(scene_name)
	return get_scene_path(scene_enum)

func is_valid_scene_name(scene_name: String) -> bool:
	return scene_name in string_to_enum

func is_valid_scene_enum(scene: Scene) -> bool:
	return scene in scene_paths
