extends RigidBody2D
class_name Flipper

@export var is_left_flipper: bool = true
@export var rest_angle: float = 0.0
@export var active_angle: float = 45.0
@export var flip_speed: float = 0.1
@export var return_speed: float = 0.15
@export var flip_force: float = 500.0
@export var max_angular_velocity: float = 20.0

#code reference to existing nodes
@onready var sprite: Sprite2D = $Sprite2D
@onready var collision_shape: CollisionPolygon2D = $CollisionPolygon2D

var is_flipping: bool = false
var current_target_angle: float
var tween: Tween

# Signals for gameplay communication
signal flipper_activated
signal flipper_deactivated
signal ball_hit(force: float)

func _ready():
	# Setup initial rotation
	rotation_degrees = rest_angle
	current_target_angle = rest_angle
	
	# Adjust angles for left flipper (mirror the angles)
	if is_left_flipper:
		active_angle = -abs(active_angle)
		sprite.flip_h = true  # Mirror sprite for left flipper
	else:
		active_angle = abs(active_angle)
	
	# Set physics properties
	gravity_scale = 0.0  # Flippers don't fall
	angular_damp = 5.0   # Damping for smooth stopping
	
	# Connect collision signal for ball interaction
	body_entered.connect(_on_body_entered)

func _physics_process(_delta):
	# Limit angular velocity for realistic movement
	if angular_velocity > max_angular_velocity:
		angular_velocity = max_angular_velocity
	elif angular_velocity < -max_angular_velocity:
		angular_velocity = -max_angular_velocity

func activate_flipper():
	"""Activate the flipper (move to active position)"""
	if is_flipping:
		return
	
	is_flipping = true
	current_target_angle = active_angle
	animate_to_angle(active_angle, flip_speed)
	
	# Add physics impulse for ball interaction
	var impulse_direction = Vector2.UP.rotated(rotation)
	apply_impulse(impulse_direction * flip_force)
	
	# Play sound effect
	#if audio_player and audio_player.stream:
	#	audio_player.play()
	
	# Emit signal
	flipper_activated.emit()

func deactivate_flipper():
	"""Deactivate the flipper (return to rest position)"""
	if not is_flipping:
		return
	
	is_flipping = false
	current_target_angle = rest_angle
	animate_to_angle(rest_angle, return_speed)
	
	# Emit signal
	flipper_deactivated.emit()

func animate_to_angle(target_angle: float, duration: float):
	"""Smoothly animate the flipper to the target angle using Tween"""
	if tween:
		tween.kill()
	
	tween = create_tween()
	tween.set_ease(Tween.EASE_OUT)
	tween.set_trans(Tween.TRANS_QUART)  # Smooth, natural movement
	
	var start_angle = rotation_degrees
	tween.tween_method(
		func(angle): rotation_degrees = angle,
		start_angle,
		target_angle,
		duration
	)

func handle_input(is_active: bool):
	"""Handle input from the gameplay scene"""
	if is_active:
		activate_flipper()
	else:
		deactivate_flipper()

func _on_body_entered(body):
	"""Handle collision with other bodies (like the ball)"""
	if body.has_method("apply_impulse"):
		var collision_force = linear_velocity.length() + abs(angular_velocity) * 10
		ball_hit.emit(collision_force)
		
		# Calculate impact direction
		var impact_direction = (body.global_position - global_position).normalized()
		var force_magnitude = collision_force * 50
		
		# Apply force to the ball
		body.apply_impulse(impact_direction * force_magnitude)

func set_flipper_type(_flipper_type: int):
	"""Set the flipper type (for different flipper styles)"""
	# This can be used to change sprites, physics properties, etc.
	pass

func get_flipper_state() -> Dictionary:
	"""Get current flipper state for debugging or saving"""
	return {
		"is_flipping": is_flipping,
		"current_angle": rotation_degrees,
		"target_angle": current_target_angle,
		"is_left": is_left_flipper
	}

# Debug function
func _draw():
	if Engine.is_editor_hint():
		# Draw rotation arc in editor
		var arc_color = Color.YELLOW if is_left_flipper else Color.CYAN
		draw_arc(Vector2.ZERO, 50, deg_to_rad(rest_angle), deg_to_rad(active_angle), 32, arc_color, 2.0)
