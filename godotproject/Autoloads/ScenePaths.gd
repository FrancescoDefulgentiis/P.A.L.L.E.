extends Node

enum Scene {
	START_SCREEN,
	LOADING_SCREEN,
	SETTINGS,
	LEVEL_SELECTION_SCREEN,
	TEST_LEVEL
}

static var scene_paths = {
	Scene.START_SCREEN: "res://Menus/Start_screen.tscn",
	Scene.LOADING_SCREEN: "res://Menus/Loading_screen.tscn",
	Scene.SETTINGS: "res://Menus/Settings.tscn",
	Scene.LEVEL_SELECTION_SCREEN: "res://Menus/Level_selection_screen.tscn",
	Scene.TEST_LEVEL: "res://Levels/TestLevel.tscn"
}

static var string_to_enum = {
	"Start_screen": Scene.START_SCREEN,
	"Loading_screen": Scene.LOADING_SCREEN,
	"Settings": Scene.SETTINGS,
	"Level_selection_screen": Scene.LEVEL_SELECTION_SCREEN,
	"Test_level": Scene.TEST_LEVEL
}

static var enum_to_string = {
	Scene.START_SCREEN: "Start_screen",
	Scene.LOADING_SCREEN: "Loading_screen",
	Scene.SETTINGS: "Settings",
	Scene.LEVEL_SELECTION_SCREEN: "Level_selection_screen",
	Scene.TEST_LEVEL: "Test_level"
}

static func get_scene_path(scene: Scene) -> String:
	if scene in scene_paths:
		return scene_paths[scene]
	return ""

static func get_enum_from_string(scene_name: String) -> Scene:
	if scene_name in string_to_enum:
		return string_to_enum[scene_name]
	return Scene.START_SCREEN  # Default fallback

static func get_string_from_enum(scene: Scene) -> String:
	if scene in enum_to_string:
		return enum_to_string[scene]
	return ""

static func get_scene_path_from_string(scene_name: String) -> String:
	var scene_enum = get_enum_from_string(scene_name)
	return get_scene_path(scene_enum)

static func is_valid_scene_name(scene_name: String) -> bool:
	return scene_name in string_to_enum

static func is_valid_scene_enum(scene: Scene) -> bool:
	return scene in scene_paths
