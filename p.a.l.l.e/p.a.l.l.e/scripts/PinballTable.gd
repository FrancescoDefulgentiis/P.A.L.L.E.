extends Node2D

@onready var left_flipper = $FlipperLeft
@onready var right_flipper = $FlipperRight

@onready var ball_spawn_point: Node2D = $BallSpawnPoint
@onready var bumper_spawn_point: Node2D = $BumperSpawnPoint
@onready var mob001_spawn_point: Node2D = $Mob001SpawnPoint
@onready var plunger_spawn_point: Node2D = $PlungerSpawnPoint
@onready var Shop_area_spawnpoint: Node2D = $ShopAreaSpawnpoint


var menu_scene: PackedScene = preload("res://scenes/mainMenu.tscn")
var menu_instance: Control = null
var palla: PackedScene = preload("res://scenes/p.a.l.l.a.tscn")
var palla_instance

var mob001: PackedScene = preload("res://scenes/mob001.tscn")
var enemy_instance

var bumper: PackedScene = preload("res://scenes/bumper.tscn")
var bumper_instance

var plunger: PackedScene = preload("res://scenes/plunger.tscn")
var plunger_instance

var shop_area: PackedScene = preload("res://scenes/shopArea.tscn")
var shop_area_instance

func _ready() -> void:
	enemy_instance = mob001.instantiate()
	enemy_instance.position = mob001_spawn_point.global_position
	add_child(enemy_instance)
	print("enemy instantiated")
	
	palla_instance = palla.instantiate()
	palla_instance.position = ball_spawn_point.global_position
	add_child(palla_instance)
	print("palla instantiated")
	
	bumper_instance = bumper.instantiate()
	bumper_instance.position = bumper_spawn_point.global_position
	add_child(bumper_instance)
	print("bumper instantiated")
	
	plunger_instance = plunger.instantiate()
	plunger_instance.position = plunger_spawn_point.global_position
	add_child(plunger_instance)
	print("plunger instantiated")

	shop_area_instance = shop_area.instantiate()
	shop_area_instance.position = Shop_area_spawnpoint.global_position
	add_child(shop_area_instance)
	print("shop area instantiated")
  

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
	
	if event.is_action_pressed("O-spacebar"): 
		plunger_instance.pull()
	elif event.is_action_released("O-spacebar"):
		plunger_instance.release()
		

func toggle_menu() -> void:
	if menu_instance == null:
		menu_instance = menu_scene.instantiate()
		add_child(menu_instance)
	else:
		menu_instance.queue_free()
		menu_instance = null
