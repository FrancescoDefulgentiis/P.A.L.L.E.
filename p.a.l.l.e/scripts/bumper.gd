extends Area3D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


const SPEED_MULTIPLIER = 2 

func velocity_evaluate(Velocity : Vector3 , Position: Vector3)-> Vector3:
	print("evaluating_trajegtory")
	var New_velocity : Vector3
	print("ball position x", Position.x)
	print("ball position y", Position.y)
	print("ball position z", Position.z)
	
	var Angle=atan2(Position.y,Position.z)
	print("collision angle: " ,rad_to_deg(Angle))
	var New_velocity_x = (Velocity.x * cos(Angle) - Velocity.y * sin(Angle)) * SPEED_MULTIPLIER
	var New_velocity_y = (Velocity.x * sin(Angle) + Velocity.y * cos(Angle)) * SPEED_MULTIPLIER

	return Vector3(New_velocity_x, New_velocity_y, 0)
	
func _on_body_entered(body):
		print("body entered")
		var Position = to_local(body.global_position) 
		var Incoming_velocity = body.linear_velocity
		var New_velocity=velocity_evaluate(Incoming_velocity,Position)
		body.linear_velocity=New_velocity
