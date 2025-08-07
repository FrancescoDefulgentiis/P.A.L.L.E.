extends Node

enum BallType {
	STANDARD,
}

var ball_scenes = {
	BallType.STANDARD: "res://Gameplay/Palle/Standard.tscn",
}

var ball_names = {
	BallType.STANDARD: "Standard",
}

func get_ball_scene_path(ball_type: BallType) -> String:
	if ball_type in ball_scenes:
		return ball_scenes[ball_type]
	return ball_scenes[BallType.STANDARD]

func get_ball_name(ball_type: BallType) -> String:
	if ball_type in ball_names:
		return ball_names[ball_type]
	return "Standard Ball"

func get_random_ball_type() -> BallType:
	var types = BallType.values()
	return types[randi() % types.size()]

func is_valid_ball_type(ball_type: BallType) -> bool:
	return ball_type in ball_scenes
