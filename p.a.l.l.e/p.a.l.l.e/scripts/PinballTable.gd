extends Node2D

@onready var left_flipper = $FlipperLeft
@onready var right_flipper = $FlipperRight

@onready var ball_spawn_point: Node2D = $BallSpawnPoint
@onready var mob001_spawn_point: Node2D = $Mob001SpawnPoint

var menu_scene: PackedScene = preload("res://scenes/mainMenu.tscn")
var menu_instance: Control = null
var palla: PackedScene = preload("res://scenes/p.a.l.l.a.tscn")
var mob001: PackedScene = preload("res://scenes/mob001.tscn")

func _ready() -> void:
	var enemy_instance = mob001.instantiate()
	enemy_instance.position = mob001_spawn_point.global_position
	add_child(enemy_instance)
	print("enemy instantiated")
	
	var palla_instance = palla.instantiate()
	palla_instance.position = ball_spawn_point.global_position
	add_child(palla_instance)
	print("palla instantiated")


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("flip_left"):
		left_flipper.upFlip()
	elif event.is_action_released("flip_left"):
		left_flipper.downFlip()
		
	if event.is_action_pressed("flip_right"):
		right_flipper.upFlip()
	elif event.is_action_released("flip_right"):
		right_flipper.downFlip()
		
	if event.is_action_pressed("ui_cancel"): 
		toggle_menu()


func toggle_menu() -> void:
	if menu_instance == null:
		menu_instance = menu_scene.instantiate()
		add_child(menu_instance)
	else:
		menu_instance.queue_free()
		menu_instance = null
