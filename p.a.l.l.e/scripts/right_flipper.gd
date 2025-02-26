extends RigidBody2D


func _ready() -> void:
	pass 


func _process(_delta):
	
	if Input.is_action_pressed("R2"):
		angular_velocity = 10
	else:
		angular_velocity = 0
	rotation = clamp(rotation, deg_to_rad(0), deg_to_rad(60))
