class_name StartScreen extends Control

func _process(_delta: float) -> void:
	# Insert here some logic to use the controller or arrows as option selectors
	pass

func _on_quit_button_button_up() -> void:
	print("Quitting game")
	get_tree().quit()

func _on_settings_button_button_up() -> void:
	print("Opening settings")
	SceneManager.swap_scenes(ScenePaths.get_scene_path("Settings"), get_tree().root, self, Transitions.Type.WIPE_TO_RIGHT)

func _on_play_button_button_up() -> void:
	print("Starting game")
	SceneManager.swap_scenes(ScenePaths.get_scene_path("Level_selection_screen"),get_tree().root,self,Transitions.Type.WIPE_TO_RIGHT)
