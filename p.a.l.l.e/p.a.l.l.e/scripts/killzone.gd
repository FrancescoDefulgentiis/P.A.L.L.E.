extends Area2D

@export var respawn_point: Node2D

var ball_scene = preload("res://scenes/p.a.l.l.a.tscn")

func _on_body_entered(body):
	print("body entered")
	if body.is_in_group("ball"):
		# Defer the entire respawn logic
		call_deferred("_respawn_ball", body)

func _respawn_ball(body):
	body.queue_free()

	var new_ball = ball_scene.instantiate() as RigidBody2D
	new_ball.global_position = respawn_point.global_position
	get_tree().current_scene.add_child(new_ball)
