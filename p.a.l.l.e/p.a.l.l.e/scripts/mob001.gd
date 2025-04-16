extends Node2D

var hit_count: int = 0
const MAX_HITS: int = 3

@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _ready() -> void:
	pass

func _on_enemy_body_entered(body: Node2D) -> void:
	if body.is_in_group("ball"):
		hit_count += 1
		animation_player.play("hit")
		print("got hit")
		if hit_count >= MAX_HITS:
			#play the death animation here
			queue_free()
