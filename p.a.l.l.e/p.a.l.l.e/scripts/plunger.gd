extends Node2D

@onready var animation_player: AnimationPlayer = $Plunger/AnimationPlayer

func _ready():
	pass

func pull():
	animation_player.play("pull")

func release():
	animation_player.play_backwards("release")
	
