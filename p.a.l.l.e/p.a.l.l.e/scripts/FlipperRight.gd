extends AnimatableBody2D

@onready var animation_player: AnimationPlayer = $AnimationPlayer


func _ready():
	pass

func upFlip():
	animation_player.play("upFlipRight")

func downFlip():
	animation_player.play_backwards("upFlipRight")
