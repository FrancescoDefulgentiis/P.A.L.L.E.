extends Node

enum FlipperType {
	STANDARD,
}

var Flipper_scenes = {
	FlipperType.STANDARD: "res://Gameplay/Flippers/Standard.tscn",
}

var Flipper_names = {
	FlipperType.STANDARD: "Standard",
}

enum FlipperPosition {
	BOTTOM_LEFT,
	BOTTOM_RIGHT
}

var Flipper_positions = {
	FlipperPosition.BOTTOM_LEFT: Vector2((BackgroundManager.table_width/6)*2, ((BackgroundManager.table_height/5)*4)),
	FlipperPosition.BOTTOM_RIGHT: Vector2((BackgroundManager.table_width/6)*4, ((BackgroundManager.table_height/5)*4))
}

func get_flipper_scene_path(flipper_type: FlipperType) -> String:
	if flipper_type in Flipper_scenes :
		return Flipper_scenes[flipper_type]
	return Flipper_scenes[FlipperType.STANDARD]

func get_flipper_name(flipper_type: FlipperType) -> String:
	if flipper_type in Flipper_names:
		return Flipper_names[flipper_type]
	return "Standard"

func get_random_flipper_type() -> FlipperType:
	var types = FlipperType.values()
	return types[randi() % types.size()]

func is_valid_flipper_type(flipper_type: FlipperType) -> bool:
	return flipper_type in Flipper_scenes

func get_flipper_position(position: FlipperPosition) -> Vector2:
	if position in Flipper_positions:
		return Flipper_positions[position]
	return Vector2.ZERO

func get_random_flipper_position() -> FlipperPosition:
	var positions = FlipperPosition.values()
	return positions[randi() % positions.size()]

func is_valid_flipper_position(position: FlipperPosition) -> bool:
	return position in Flipper_positions

func is_left_position(position: FlipperPosition) -> bool:
	return position in [FlipperPosition.BOTTOM_LEFT]
	
func is_right_position(position: FlipperPosition) -> bool:
	return position in [FlipperPosition.BOTTOM_RIGHT]
