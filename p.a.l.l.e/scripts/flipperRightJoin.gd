extends HingeJoint3D

const LIMIT_LOWER = -25
const LIMIT_UPPER = 10

func _ready():
	set_flag(FLAG_USE_LIMIT, true)
	set_param(PARAM_LIMIT_LOWER, deg_to_rad(LIMIT_LOWER))
	set_param(PARAM_LIMIT_UPPER, deg_to_rad(LIMIT_UPPER))
	
	set_flag(FLAG_ENABLE_MOTOR, true)
	set_param(PARAM_MOTOR_MAX_IMPULSE, 5.0)
	set_param(PARAM_MOTOR_TARGET_VELOCITY, 5.0)

func _physics_process(_delta):
	if Input.is_action_pressed("R2"):
		set_param(PARAM_MOTOR_TARGET_VELOCITY, 5.0)	# Go Up
	else:
		set_param(PARAM_MOTOR_TARGET_VELOCITY, -5.0)# Goes down
