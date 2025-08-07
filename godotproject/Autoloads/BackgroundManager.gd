extends Node

# Table configuration
@export var table_width: float = 240.0
@export var table_height: float = 144
@export var wall_thickness: float = 20.0

enum BackgroundType {
	TEST
}

var background_scenes = {
	BackgroundType.TEST: "res://Gameplay/Backgrounds/Test.tscn"
}

var background_names = {
	BackgroundType.TEST: "Test"
}

var background_walls = {
		BackgroundType.TEST: "res://Gameplay/Walls/WallBox.tscn"
}

func get_background_scene_path(background_type: BackgroundType) -> String:
	if background_type in background_scenes:
		return background_scenes[background_type]
	return background_scenes[BackgroundType.TEST] 

func get_background_name(background_type: BackgroundType) -> String:
	if background_type in background_names:
		return background_names[background_type]
	return "Test"  # Default name

func get_background_walls_path(background_type: BackgroundType) -> String:
	if background_type in background_walls:
		return background_walls[background_type]
	return "res://Gameplay/Walls/WallBox.tscn"  # Default path

func get_random_background_type() -> BackgroundType:
	var types = BackgroundType.values()
	return types[randi() % types.size()]

func is_valid_background_type(background_type: BackgroundType) -> bool:
	return background_type in background_scenes

func get_all_background_types() -> Array[BackgroundType]:
	var types: Array[BackgroundType] = []
	for type in BackgroundType.values():
		types.append(type)
	return types
