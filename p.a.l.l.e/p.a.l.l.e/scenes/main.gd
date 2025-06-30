extends Node

enum GameState {
	MAIN_MENU,
	PLAYING,
	PAUSED,
	GAME_OVER
}

var current_state: GameState = GameState.MAIN_MENU
var current_scene: Node

func _ready():
	load_scene("res://scenes/menus/MainMenu.tscn")

func load_scene(scene_path: String):
	if current_scene:
		current_scene.queue_free()
	
	var new_scene = load(scene_path).instantiate()
	add_child(new_scene)
	current_scene = new_scene
