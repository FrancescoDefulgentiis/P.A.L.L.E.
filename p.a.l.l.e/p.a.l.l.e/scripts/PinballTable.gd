extends Node2D

@onready var left_flipper = $FlipperLeft
@onready var right_flipper = $FlipperRight

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("flip_left"):
		left_flipper.upFlip()
	elif event.is_action_released("flip_left"):
		left_flipper.downFlip()
		
	if event.is_action_pressed("flip_right"):
		right_flipper.upFlip()
	elif event.is_action_released("flip_right"):
		right_flipper.downFlip()
