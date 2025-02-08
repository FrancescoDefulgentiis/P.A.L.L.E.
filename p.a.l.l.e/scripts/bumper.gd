extends Area3D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


<<<<<<< Updated upstream
const SPEED_MULTIPLIER = 10 # Increase speed by 50%

func velocity_evaluate(Velocity : Vector3 , Position: Vector3)-> Vector3:
	print("evaluating_trajegtory")
	var new_velocity : Vector3
	var radius=$CollisionShape3D.shape.radius
	print("ball position: " ,Position)
	var angle=atan2(Position.y,Position.x)
	angle=(angle*180)/3.14
	Velocity.x=(Velocity.x*cos(angle)+Velocity.y*cos(angle))*SPEED_MULTIPLIER
	Velocity.y=(Velocity.x*sin(angle)+Velocity.y*sin(angle))
	Velocity.z=0
	return Velocity
	
func _on_body_entered(body):
		print("body entered")
		var normal = to_local(body.global_position) # Adjust the normal based on collision direction
		var incoming_velocity = body.linear_velocity
		var new_velocity=velocity_evaluate(incoming_velocity,normal)
		body.linear_velocity=new_velocity
=======
const SPEED_MULTIPLIER = 1

func velocity_evaluate(Velocity : Vector3 , Position: Vector3)-> Vector3:
	print("evaluating_trajegtory")
	var New_velocity : Vector3
	var Angle=atan2(Position.y,Position.x)
	print("collision angle: " ,rad_to_deg(Angle))
	print("starting Velocity: ",Velocity)
	var New_velocity_x = ((Velocity.x * cos(Angle) - Velocity.y * sin(Angle)) * SPEED_MULTIPLIER)*sign(cos(Angle))
	var New_velocity_y = ((Velocity.x * sin(Angle) + Velocity.y * cos(Angle)) * SPEED_MULTIPLIER)*sign(sin(Angle))
	print(New_velocity_x," ",New_velocity_y)
	return Vector3(New_velocity_x, New_velocity_y, 0)
	
func _on_body_entered(body):
		print("body entered")
		
		var Position = body.global_position-global_position
		var Incoming_velocity = body.linear_velocity
		var New_velocity=velocity_evaluate(Incoming_velocity,Position)
		body.linear_velocity=New_velocity
>>>>>>> Stashed changes
