extends StaticBody2D

var menu_scene: PackedScene = preload("res://scenes/shopMenu.tscn")
var menu_instance: Control = null

func _on_hit_sensor_body_entered(_body: Node2D) -> void:
	toggle_menu()
	
func toggle_menu():
	if menu_instance == null:
		# pause everything else
		get_tree().paused = true

		# instantiate the menu
		menu_instance = menu_scene.instantiate() as Control

		# allow it to process while paused
		menu_instance.process_mode = Node.PROCESS_MODE_WHEN_PAUSED

		# ensure it’s visible
		menu_instance.visible = true

		# add it to the scene tree
		add_child(menu_instance)

		# show the cursor so you can click buttons
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	else:
		# unpause world
		get_tree().paused = false

		# remove and free the menu
		menu_instance.queue_free()
		menu_instance = null

		# hide cursor for gameplay
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
