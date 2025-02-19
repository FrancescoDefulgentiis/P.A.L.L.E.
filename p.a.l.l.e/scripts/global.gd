extends Node

func _ready():
	var gravity_strength = 9.8
	var angle = deg_to_rad(30)
	var gravity = Vector3(0, -cos(angle) * gravity_strength, sin(angle) * gravity_strength)	# Define new gravity vector so that the table appears inclined
	ProjectSettings.set_setting("physics/3d/default_gravity_vector", gravity)	# Set the gravity vector
	PhysicsServer3D.area_set_param(get_viewport().find_world_3d().space, PhysicsServer3D.AREA_PARAM_GRAVITY_VECTOR, gravity)	# Use the gravity vector
	pass
	
func _process(_delta: float) -> void:
	pass
