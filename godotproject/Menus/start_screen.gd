class_name StartScreen extends Control

func _on_button_button_up() -> void:
	print("this one")
	SceneManager.swap_scenes("res://Gameplay/gameplay.tscn",get_tree().root,self,"wipe_to_right")
	
func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("ui_accept"):
		SceneManager.swap_scenes("res://Gameplay/gameplay.tscn",get_tree().root,self,"wipe_to_right")
