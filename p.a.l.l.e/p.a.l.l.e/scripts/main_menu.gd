extends Control

var scene_path = "res://scenes/PinballTable.tscn"

func _on_play_button_pressed() -> void:
	if ResourceLoader.exists(scene_path):
		get_tree().change_scene_to_file(scene_path)
	else:
		print("Scene not found: ", scene_path)

func _on_quit_button_pressed() -> void:
	get_tree().quit()


func _on_options_button_pressed() -> void:
	print("Options button pressed")
