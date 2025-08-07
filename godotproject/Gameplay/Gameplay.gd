extends Node2D

var data:LevelDataHandoff
var selectedCharacter: String
var selectedBackground: BackgroundManager.BackgroundType
var selectedBall: PalleManager.BallType
var selectedFlippers: FlipperManager.FlipperType

# Preload scenes for better performance
@export var wall_box_scene: PackedScene = preload("res://Gameplay/Walls/WallBox.tscn")
@export var left_flipper: Flipper
@export var right_flipper: Flipper
#@export var flipper_scene: PackedScene = preload("res://Flipper.tscn")
#@export var obstacle_scene: PackedScene = preload("res://Obstacle.tscn")

# Container nodes for organization
var background_layer: Node2D
var wall_layer: Node2D
var obstacle_layer: Node2D
var flipper_layer: Node2D
var ball_layer: Node2D
var ui_layer: CanvasLayer

func _process(_delta):
	if Input.is_action_just_pressed("left_flip"):
		left_flipper.handle_input(true)
	elif Input.is_action_just_released("left_flip"):
		left_flipper.handle_input(false)
	
	# Handle right flipper  
	if Input.is_action_just_pressed("right_flip"):
		right_flipper.handle_input(true)
	elif Input.is_action_just_released("right_flip"):
		right_flipper.handle_input(false)

func receive_data(_data):
	if _data is LevelDataHandoff:
		data = _data
		selectedBackground = data.getBackground()
		selectedBall = data.getBall()
		selectedFlippers = data.getFlipper()
		setup_layers()
		await build_table(BackgroundManager.BackgroundType.TEST, PalleManager.BallType.STANDARD)
	else:
		push_warning("Level is receiving data it cannot process")

func setup_layers():
	
	background_layer = Node2D.new()
	background_layer.name = "BackgroundLayer"
	add_child(background_layer)
	
	wall_layer = Node2D.new()
	wall_layer.name = "WallLayer"
	add_child(wall_layer)
	
	obstacle_layer = Node2D.new()
	obstacle_layer.name = "ObstacleLayer"
	add_child(obstacle_layer)
	
	flipper_layer = Node2D.new()
	flipper_layer.name = "FlipperLayer"
	add_child(flipper_layer)
	
	ball_layer = Node2D.new()
	ball_layer.name = "BallLayer"
	add_child(ball_layer)
	
	ui_layer = CanvasLayer.new()
	ui_layer.name = "UILayer"
	add_child(ui_layer)

func build_table(background_type: BackgroundManager.BackgroundType, ball_type: PalleManager.BallType):
	print("Starting table construction...")
	
	await select_background(background_type)
	await place_walls(background_type)
	await place_obstacles(background_type)
	await place_flippers(selectedFlippers)
	await finish_loading()
	await place_ball(ball_type)
	
	print("Table construction complete!")

func select_background(background_type: BackgroundManager.BackgroundType):
	print("### Background: ", BackgroundManager.get_background_name(background_type))
	
	var background_scene_path = BackgroundManager.get_background_scene_path(background_type)
	if background_scene_path:
		var background_scene = load(background_scene_path)
		if background_scene:
			var background_instance = background_scene.instantiate()
			background_layer.add_child(background_instance)
			print("	Background loaded: ", BackgroundManager.get_background_name(background_type))
	else:
		print("	No valid background scene found for type: ", background_type)

func place_walls(background_type: BackgroundManager.BackgroundType):
	print("### Walls")
	var background_wall_path = BackgroundManager.get_background_walls_path(background_type)
	if background_wall_path:
		var wall_scene = load(background_wall_path)
		if wall_scene:
			var wall_instance = wall_scene.instantiate()
			wall_instance.position = Vector2(0, 0)
			wall_layer.add_child(wall_instance)
			print("	Walls loaded for background: ", BackgroundManager.get_background_name(background_type))
	else:
		print("	No valid wall scene found for background type: ", background_type)
	
func place_obstacles(_background_type: BackgroundManager.BackgroundType):
	print("### Obstacles")

func place_flippers(flipper_type: FlipperManager.FlipperType):
	print("### Flippers...")
	var flipper_scene_path = FlipperManager.get_flipper_scene_path(flipper_type)
	if flipper_scene_path:
		var flipper_scene = load(flipper_scene_path)
		if flipper_scene:
			setup_flipper(flipper_scene, FlipperManager.FlipperPosition.BOTTOM_LEFT, true)
			setup_flipper(flipper_scene, FlipperManager.FlipperPosition.BOTTOM_RIGHT, false)
			print("	Flippers loaded for type: ", FlipperManager.get_flipper_name(flipper_type))
		else:
			print("	Failed to load flipper scene at path: ", flipper_scene_path)
	else:
		print("	No valid flipper scene found for type: ", flipper_type)

func finish_loading():
	print("### Finishing loading...")

func place_ball(ball_type: PalleManager.BallType):
	print("### Ball")
	create_ball_at(ball_type)

func create_ball_at(ball_type: PalleManager.BallType, spawn_position: Vector2 = Vector2()) -> RigidBody2D:
	var ball_spawn_pos = spawn_position
	var ball_scene_path = PalleManager.get_ball_scene_path(ball_type)
	if ball_spawn_pos == Vector2():
		ball_spawn_pos = Vector2(BackgroundManager.table_width/2, BackgroundManager.table_height/2)
	if ball_scene_path:
		var ball_resource = load(ball_scene_path)
		if ball_resource:
			var ball_instance = ball_resource.instantiate()
			ball_instance.position = ball_spawn_pos  # Set the position before adding to scene
			ball_layer.add_child(ball_instance)
			print("	Ball spawn position: ", ball_spawn_pos)
			print("	Ball actual position: ", ball_instance.position)
			return ball_instance
		else:
			print("	Failed to load ball scene at path: ", ball_scene_path)
	else:
		print("	No valid ball scene found for type: ", ball_type)
	return null

func setup_flipper(flipper_scene: PackedScene, positioning: FlipperManager.FlipperPosition, is_left: bool):
	var flipper = flipper_scene.instantiate()
	var coordinates = FlipperManager.Flipper_positions.get(positioning, Vector2.ZERO)
	print("flipper coordinates are: ", coordinates)
	flipper.position = coordinates
	flipper.is_left_flipper = is_left

	if is_left:
		flipper.name = "LeftFlipper"
		left_flipper = flipper
	else:
		flipper.name = "RightFlipper"
		right_flipper = flipper

	flipper_layer.add_child(flipper)

	var pin_joint: PinJoint2D = flipper.get_node_or_null("PinJoint2D")
	print(flipper.get_path())
	if pin_joint:
		pin_joint.node_a = flipper.get_path()
		pin_joint.position = Vector2.ZERO
	else:
		push_warning("PinJoint2D not found in flipper scene")

func clear_table():
	for child in obstacle_layer.get_children():
		child.queue_free()
	
	for child in ball_layer.get_children():
		child.queue_free()

func _on_obstacle_hit(_obstacle: Node2D, points: int):
	print("Obstacle hit! Points: ", points)
	# Add scoring logic here
	# Optional: Remove obstacle after hit (for destructible elements)
