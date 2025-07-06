class_name Settings extends CanvasLayer

func _process(_delta: float) -> void:
	# Insert here some logic to use the controller or arrows as option selectors
	pass

func _on_quit_button_button_up() -> void:
	print("Quitting game")
	get_tree().quit()

func _on_close_button_button_up() -> void:
	print("closing settings")
	SceneManager.swap_scenes(ScenePaths.get_scene_path(ScenePaths.Scene.START_SCREEN), get_tree().root, self, Transitions.Type.WIPE_TO_RIGHT)

func _on_save_button_button_up() -> void:
	print("Saving settings...")
	#Insert here some logic to save settings
