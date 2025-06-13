extends Control

const Upgrades_Utils = preload("res://scripts/utils/upgrades_utils.gd")
var scene_path = "res://scenes/PinballTable.tscn"

var upgrades_utils_instance = Upgrades_Utils.new()
var upgrades = Upgrades_Utils.upgrades
var upgrade_names = Upgrades_Utils.UPGRADE_NAMES

func _on_option_1_pressed() -> void:
	# 1) If the game is paused AND the parent has toggle_menu(), resume instead of reloading
	if get_tree().paused and get_parent().has_method("toggle_menu"):
		var upgrade_enum = upgrades_utils_instance.get_upgrade_key_from_name($screen/Option1.text)
		if upgrade_enum == -1:
			push_error("Invalid upgrade name: %s" % $screen/Option1.text)
		else:
			get_parent().apply_upgrade(upgrade_enum)
		get_parent().toggle_menu()
		return

	# 2) Otherwise—this must be the initial main‑menu—load the table scene
	if ResourceLoader.exists(scene_path):
		get_tree().change_scene_to_file(scene_path)
	else:
		push_error("Scene not found: %s" % scene_path)

func _on_Option2_pressed():
	if get_tree().paused and get_parent().has_method("toggle_menu"):
		var upgrade_enum = upgrades_utils_instance.get_upgrade_key_from_name($screen/Option2.text)
		if upgrade_enum == -1:
			push_error("Invalid upgrade name: %s" % $screen/Option2.text)
		else:
			get_parent().apply_upgrade(upgrade_enum)
		get_parent().toggle_menu()
		return
	if ResourceLoader.exists(scene_path):
		get_tree().change_scene_to_file(scene_path)
	else:
		push_error("Scene not found: %s" % scene_path)

func _on_Option3_pressed():
	if get_tree().paused and get_parent().has_method("toggle_menu"):
		var upgrade_enum = upgrades_utils_instance.get_upgrade_key_from_name($screen/Option3.text)
		if upgrade_enum == -1:
			push_error("Invalid upgrade name: %s" % $screen/Option3.text)
		else:
			get_parent().apply_upgrade(upgrade_enum)
		get_parent().toggle_menu()
		return
	if ResourceLoader.exists(scene_path):
		get_tree().change_scene_to_file(scene_path)
	else:
		push_error("Scene not found: %s" % scene_path)
