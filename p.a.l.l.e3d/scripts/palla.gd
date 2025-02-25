extends RigidBody3D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	freeze = false  # Ensure the body is not frozen

# Called every physics frame
func _physics_process(_delta: float) -> void:
	pass
