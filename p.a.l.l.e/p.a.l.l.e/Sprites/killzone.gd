extends Area2D

@export var respawn_point: Node2D
@export var ball: RigidBody2D

func _on_body_entered(body):
	if body == ball:
		ball.linear_velocity = Vector2.ZERO
		ball.angular_velocity = 0
		ball.position = respawn_point.global_position
