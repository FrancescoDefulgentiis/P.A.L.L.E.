extends RigidBody3D

var target_angular_velocity = 0.0  # Target speed of rotation, starts at 0
var motor_force = 25.0             # Torque strength, acts like motor power
var max_speed = 10.0               # Maximum rotational speed

var min_angle = -10    # The minimum reachable angle 
var max_angle = 20     # The maximum reachable angle 

func _physics_process(_delta):
	var current_angle = rotation_degrees.y

	if Input.is_action_pressed("L2"):
		target_angular_velocity = max_speed		# Pressing rotates in the positive direction
	else:
		target_angular_velocity = -max_speed	# Releasing rotates back to rest in the negative direction

	# Prevent the flipper from exceeding its limits:
	if current_angle <= min_angle and target_angular_velocity < 0:
		target_angular_velocity = 0
	if current_angle >= max_angle and target_angular_velocity > 0:
		target_angular_velocity = 0

	var torque = (target_angular_velocity - angular_velocity.y) * motor_force
	apply_torque(Vector3(0, torque, 0))
