extends Control

var scene_path = "res://scenes/PinballTable.tscn"

func _on_play_button_pressed():
	# 1) If the game is paused AND the parent has toggle_menu(), resume instead of reloading
	if get_tree().paused and get_parent().has_method("toggle_menu"):
		get_parent().toggle_menu()
		return

	# 2) Otherwise—this must be the initial main‑menu—load the table scene
	if ResourceLoader.exists(scene_path):
		get_tree().change_scene_to_file(scene_path)
	else:
		push_error("Scene not found: %s" % scene_path)

func _on_quit_button_pressed():
	# 1) If the game is paused AND the parent has toggle_menu(), resume instead of reloading
	if get_tree().paused and get_parent().has_method("toggle_menu"):
		get_parent().toggle_menu()
		return

	# 2) Otherwise—this must be the initial main‑menu—load the table scene
	if ResourceLoader.exists(scene_path):
		get_tree().change_scene_to_file(scene_path)
	else:
		push_error("Scene not found: %s" % scene_path)

func _on_options_button_pressed():
	# 1) If the game is paused AND the parent has toggle_menu(), resume instead of reloading
	if get_tree().paused and get_parent().has_method("toggle_menu"):
		get_parent().toggle_menu()
		return

	# 2) Otherwise—this must be the initial main‑menu—load the table scene
	if ResourceLoader.exists(scene_path):
		get_tree().change_scene_to_file(scene_path)
	else:
		push_error("Scene not found: %s" % scene_path)
