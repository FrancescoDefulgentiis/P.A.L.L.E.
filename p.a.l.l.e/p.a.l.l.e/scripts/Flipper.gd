extends AnimatableBody2D

# The rotation angles (in degrees) when resting and when flipped.
@export var resting_rotation: float 
@export var flip_rotation: float
@export var flip_duration: float

func _ready():
	rotation_degrees = resting_rotation

func upFlip():
	var tween = create_tween()
	tween.tween_property(self, "rotation_degrees", flip_rotation, -flip_duration).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)

func downFlip():
	var tween = create_tween()
	tween.tween_property(self, "rotation_degrees", resting_rotation, -flip_duration).set_delay(flip_duration).set_trans(Tween.TRANS_BOUNCE).set_ease(Tween.EASE_OUT)
