extends Node2D
@onready var sprite = $AnimatedSprite2D
@onready var prior_frame  = -1

func _on_animated_sprite_2d_frame_changed() -> void:
	var f = sprite.frame
	# disable old
	if prior_frame >= 0:
		$".Coll% d".format(prior_frame).disabled = true
	# enable new
	$".Coll% d".format(f).disabled = false
	prior_frame = f
	
func upFlip():
	pass
	
func downFlip():
	pass
