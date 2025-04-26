extends StaticBody2D

@onready var animation_player: AnimationPlayer = $AnimationPlayer

var bounciness = 1.2 # adds 20% energy to the ball

func _ready() -> void:
	pass

func _on_hit_sensor_body_entered(body: Node2D) -> void:
	if body.is_in_group("ball"):
		animation_player.play("hit")
		body.linear_velocity *= bounciness
		print("bumper got hit")
