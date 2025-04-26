extends Node2D

@onready var animation_player: AnimationPlayer = $AnimationPlayer

# physical parameters
var max_pullback: float = 1.0
var spring_constant: float = 250000.0

var pull_progress: float = 0.0

func pull():
	animation_player.play("pull")

func release():
	# compute how "charged" we are
	pull_progress = clamp(
		animation_player.current_animation_position
		/ animation_player.current_animation_length,
		0.0, 1.0
	)
	
	animation_player.play_backwards("release")

func _on_sensor_body_entered(body: Node) -> void:
	if body.is_in_group("ball") and body is RigidBody2D:
		var rigid_ball = body as RigidBody2D
		rigid_ball.sleeping = false

		var x = pull_progress * max_pullback
		var impulse = x * sqrt(spring_constant * rigid_ball.mass)

		# PUSH UP instead of right:
		rigid_ball.apply_impulse(Vector2.UP * impulse, Vector2.ZERO)
		pull_progress=0
