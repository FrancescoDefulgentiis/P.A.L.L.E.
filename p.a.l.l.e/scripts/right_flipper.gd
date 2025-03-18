extends RigidBody2D

@export var flipper_strength: float = 80000  # Force applied to the flipper
@export var key_bind: String = "R2"      

var is_flipping: bool = false

func _ready():
	physics_material_override = PhysicsMaterial.new()
	physics_material_override.friction = 1.0
	physics_material_override.bounce = 0.0

func _process(_delta):
	if Input.is_action_just_pressed(key_bind):
		is_flipping = true
	elif Input.is_action_just_released(key_bind):
		is_flipping = false

func _physics_process(delta):
	if is_flipping:
		apply_torque(flipper_strength)
	else:
		apply_torque(0)  
