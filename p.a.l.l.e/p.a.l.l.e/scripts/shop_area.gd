extends StaticBody2D

const Upgrades_Utils = preload("res://scripts/utils/upgrades_utils.gd")
const stat_utils = preload("res://scripts/utils/stats_utils.gd")
var menu_scene: PackedScene = preload("res://scenes/shopMenu.tscn")

var menu_instance: Control = null
var root_node = null
var ball = null
var stats = null

func _ready():
	root_node = get_tree().current_scene
	ball = root_node.get_node("Palla")
	stats = root_node.get_node("Stats")

var upgrades = Upgrades_Utils.upgrades
var upgrade_names = Upgrades_Utils.UPGRADE_NAMES
var upgrade_descriptions = Upgrades_Utils.UPGRADE_DESCRIPTIONS
var upgrade_prices = Upgrades_Utils.UPGRADE_PRICES


func _on_hit_sensor_body_entered(_body: Node2D) -> void:
	toggle_menu()
	
# this function is called once to pick 3 different upgrades to put them in the shop
func pick_upgrades():
	var picked_upgrades = []
	var upgrade_count = 3
	while picked_upgrades.size() < upgrade_count:
		var random_upgrade = randi() % upgrades.size()
		if not picked_upgrades.has(random_upgrade):
			picked_upgrades.append(random_upgrade)
	return picked_upgrades

func toggle_menu():
	if menu_instance == null:
		# pause everything else
		get_tree().paused = true

		# instantiate the menu
		menu_instance = menu_scene.instantiate() as Control
		var picked_upgrades = pick_upgrades()
		for i in range(picked_upgrades.size()):
			menu_instance.get_node("screen/Option" + str(i + 1)).text = upgrade_names[picked_upgrades[i]]
		
		# allow it to process while paused
		menu_instance.process_mode = Node.PROCESS_MODE_WHEN_PAUSED

		# ensure it’s visible
		menu_instance.visible = true

		# add it to the scene tree
		add_child(menu_instance)

		# show the cursor so you can click buttons
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	else:
		# unpause world
		get_tree().paused = false

		# remove and free the menu
		menu_instance.queue_free()
		menu_instance = null

		# hide cursor for gameplay
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		
func apply_upgrade(upgrade_to_apply: Upgrades_Utils.upgrades) -> void:
	match upgrade_to_apply:
		Upgrades_Utils.upgrades.BALL_BOUNCE_UP:
			var current_stats = stats.get_stat(stat_utils.stats.BALL_BOUNCE)
			current_stats += 0.1
			stats.update_stat(stat_utils.stats.BALL_BOUNCE, current_stats)
		Upgrades_Utils.upgrades.BALL_BOUNCE_DOWN:
			var current_stats = stats.get_stat(stat_utils.stats.BALL_BOUNCE)
			current_stats -= 0.1    
			stats.update_stat(stat_utils.stats.BALL_BOUNCE, current_stats)
		Upgrades_Utils.upgrades.BALL_SIZE_UP:
			var current_stats = stats.get_stat(stat_utils.stats.BALL_SIZE)
			current_stats += 1
			stats.update_stat(stat_utils.stats.BALL_SIZE, current_stats)
		Upgrades_Utils.upgrades.BALL_SIZE_DOWN:
			var current_stats = stats.get_stat(stat_utils.stats.BALL_SIZE)
			current_stats -= 1
			stats.update_stat(stat_utils.stats.BALL_SIZE, current_stats)
		Upgrades_Utils.upgrades.BALL_DAMAGE_TO_ENEMIES_UP:
			var current_stats = stats.get_stat(stat_utils.stats.BALL_DAMAGE_TO_ENEMIES)
			current_stats += 0.1
			stats.update_stat(stat_utils.stats.BALL_DAMAGE_TO_ENEMIES, current_stats)
		Upgrades_Utils.upgrades.BALL_DAMAGE_TO_ENEMIES_DOWN:
			var current_stats = stats.get_stat(stat_utils.stats.BALL_DAMAGE_TO_ENEMIES)
			current_stats -= 0.1
			stats.update_stat(stat_utils.stats.BALL_DAMAGE_TO_ENEMIES, current_stats)
		Upgrades_Utils.upgrades.BALL_DAMAGE_TO_STRUCTURES_UP:
			var current_stats = stats.get_stat(stat_utils.stats.BALL_DAMAGE_TO_STRUCTURES)
			current_stats += 0.1
			stats.update_stat(stat_utils.stats.BALL_DAMAGE_TO_STRUCTURES, current_stats)
		Upgrades_Utils.upgrades.BALL_DAMAGE_TO_STRUCTURES_DOWN:
			var current_stats = stats.get_stat(stat_utils.stats.BALL_DAMAGE_TO_STRUCTURES)
			current_stats -= 0.1
			stats.update_stat(stat_utils.stats.BALL_DAMAGE_TO_STRUCTURES, current_stats)
		Upgrades_Utils.upgrades.BALL_DAMAGE_TO_BOSSES_UP:
			var current_stats = stats.get_stat(stat_utils.stats.BALL_DAMAGE_TO_BOSSES)
			current_stats += 0.1
			stats.update_stat(stat_utils.stats.BALL_DAMAGE_TO_BOSSES, current_stats)
		Upgrades_Utils.upgrades.BALL_DAMAGE_TO_BOSSES_DOWN:
			var current_stats = stats.get_stat(stat_utils.stats.BALL_DAMAGE_TO_BOSSES)
			current_stats -= 0.1
			stats.update_stat(stat_utils.stats.BALL_DAMAGE_TO_BOSSES, current_stats)
		Upgrades_Utils.upgrades.BALL_DAMAGE_UP:
			var current_stats = stats.get_stat(stat_utils.stats.BALL_DAMAGE)
			current_stats += 1
			stats.update_stat(stat_utils.stats.BALL_DAMAGE, current_stats)
		Upgrades_Utils.upgrades.BALL_DAMAGE_DOWN:
			var current_stats = stats.get_stat(stat_utils.stats.BALL_DAMAGE)
			current_stats -= 1
			stats.update_stat(stat_utils.stats.BALL_DAMAGE, current_stats)
		Upgrades_Utils.upgrades.BALL_ELEMENTAL_DAMAGE_UP:
			var current_stats = stats.get_stat(stat_utils.stats.BALL_ELEMENTAL_DAMAGE)
			current_stats += 1
			stats.update_stat(stat_utils.stats.BALL_ELEMENTAL_DAMAGE, current_stats)
		Upgrades_Utils.upgrades.BALL_ELEMENTAL_DAMAGE_DOWN:
			var current_stats = stats.get_stat(stat_utils.stats.BALL_ELEMENTAL_DAMAGE)
			current_stats -= 1
			stats.update_stat(stat_utils.stats.BALL_ELEMENTAL_DAMAGE, current_stats)
		Upgrades_Utils.upgrades.BALL_KNOCKBACK_UP:
			var current_stats = stats.get_stat(stat_utils.stats.BALL_KNOCKBACK)
			current_stats += 1
			stats.update_stat(stat_utils.stats.BALL_KNOCKBACK, current_stats)
		Upgrades_Utils.upgrades.BALL_KNOCKBACK_DOWN:
			var current_stats = stats.get_stat(stat_utils.stats.BALL_KNOCKBACK)
			current_stats -= 1
			stats.update_stat(stat_utils.stats.BALL_KNOCKBACK, current_stats)
		Upgrades_Utils.upgrades.BALL_CRITICAL_HIT_CHANCE_UP:    
			var current_stats = stats.get_stat(stat_utils.stats.BALL_CRITICAL_HIT_CHANCE)
			current_stats += 1
			stats.update_stat(stat_utils.stats.BALL_CRITICAL_HIT_CHANCE, current_stats)
		Upgrades_Utils.upgrades.BALL_CRITICAL_HIT_CHANCE_DOWN:
			var current_stats = stats.get_stat(stat_utils.stats.BALL_CRITICAL_HIT_CHANCE)
			current_stats -= 1
			stats.update_stat(stat_utils.stats.BALL_CRITICAL_HIT_CHANCE, current_stats)
		Upgrades_Utils.upgrades.BALL_HEALTH_UP:
			var current_stats = stats.get_stat(stat_utils.stats.BALL_HEALTH)
			current_stats += 1
			stats.update_stat(stat_utils.stats.BALL_HEALTH, current_stats)
		Upgrades_Utils.upgrades.BALL_HEALTH_DOWN:
			var current_stats = stats.get_stat(stat_utils.stats.BALL_HEALTH)
			current_stats -= 1
			stats.update_stat(stat_utils.stats.BALL_HEALTH, current_stats)
		Upgrades_Utils.upgrades.BALL_HEALTH_REGEN_UP:
			var current_stats = stats.get_stat(stat_utils.stats.BALL_HEALTH_REGEN)
			current_stats += 0.1
			stats.update_stat(stat_utils.stats.BALL_HEALTH_REGEN, current_stats)
		Upgrades_Utils.upgrades.BALL_HEALTH_REGEN_DOWN:
			var current_stats = stats.get_stat(stat_utils.stats.BALL_HEALTH_REGEN)
			current_stats -= 0.1
			stats.update_stat(stat_utils.stats.BALL_HEALTH_REGEN, current_stats)
		Upgrades_Utils.upgrades.FLIPPER_SPEED_UP:
			var current_stats = stats.get_stat(stat_utils.stats.FLIPPER_SPEED)
			current_stats += 0.1
			stats.update_stat(stat_utils.stats.FLIPPER_SPEED, current_stats)
		Upgrades_Utils.upgrades.FLIPPER_SPEED_DOWN:
			var current_stats = stats.get_stat(stat_utils.stats.FLIPPER_SPEED)
			current_stats -= 0.1
			stats.update_stat(stat_utils.stats.FLIPPER_SPEED, current_stats)
		Upgrades_Utils.upgrades.FLIPPER_PRECISION_UP:
			var current_stats = stats.get_stat(stat_utils.stats.FLIPPER_PRECISION)
			current_stats += 1
			stats.update_stat(stat_utils.stats.FLIPPER_PRECISION, current_stats)
		Upgrades_Utils.upgrades.FLIPPER_PRECISION_DOWN:
			var current_stats = stats.get_stat(stat_utils.stats.FLIPPER_PRECISION)
			current_stats -= 1
			stats.update_stat(stat_utils.stats.FLIPPER_PRECISION, current_stats)
		Upgrades_Utils.upgrades.BUMPER_EXPANSION_SPEED_UP:
			var current_stats = stats.get_stat(stat_utils.stats.BUMPER_EXPANSION_SPEED)
			current_stats += 0.1
			stats.update_stat(stat_utils.stats.BUMPER_EXPANSION_SPEED, current_stats)
		Upgrades_Utils.upgrades.BUMPER_EXPANSION_SPEED_DOWN:
			var current_stats = stats.get_stat(stat_utils.stats.BUMPER_EXPANSION_SPEED)
			current_stats -= 0.1
			stats.update_stat(stat_utils.stats.BUMPER_EXPANSION_SPEED, current_stats)
		Upgrades_Utils.upgrades.BUMPER_PRECISION_UP:
			var current_stats = stats.get_stat(stat_utils.stats.BUMPER_PRECISION)
			current_stats += 1
			stats.update_stat(stat_utils.stats.BUMPER_PRECISION, current_stats)
		Upgrades_Utils.upgrades.BUMPER_PRECISION_DOWN:
			var current_stats = stats.get_stat(stat_utils.stats.BUMPER_PRECISION)
			current_stats -= 1
			stats.update_stat(stat_utils.stats.BUMPER_PRECISION, current_stats)
		Upgrades_Utils.upgrades.XP_GAIN_UP:
			var current_stats = stats.get_stat(stat_utils.stats.XP_GAIN)
			current_stats += 0.1
			stats.update_stat(stat_utils.stats.XP_GAIN, current_stats)
		Upgrades_Utils.upgrades.XP_GAIN_DOWN:
			var current_stats = stats.get_stat(stat_utils.stats.XP_GAIN)
			current_stats -= 0.1
			stats.update_stat(stat_utils.stats.XP_GAIN, current_stats)
		Upgrades_Utils.upgrades.PICKUP_RANGE_UP:
			var current_stats = stats.get_stat(stat_utils.stats.PICKUP_RANGE)
			current_stats += 1
			stats.update_stat(stat_utils.stats.PICKUP_RANGE, current_stats)
		Upgrades_Utils.upgrades.PICKUP_RANGE_DOWN:
			var current_stats = stats.get_stat(stat_utils.stats.PICKUP_RANGE)
			current_stats -= 1
			stats.update_stat(stat_utils.stats.PICKUP_RANGE, current_stats) 
		Upgrades_Utils.upgrades.ITEMS_DISCOUNT_UP:
			var current_stats = stats.get_stat(stat_utils.stats.ITEMS_DISCOUNT)
			current_stats += 0.1
			stats.update_stat(stat_utils.stats.ITEMS_DISCOUNT, current_stats)
		Upgrades_Utils.upgrades.ITEMS_DISCOUNT_DOWN:
			var current_stats = stats.get_stat(stat_utils.stats.ITEMS_DISCOUNT)
			current_stats -= 0.1
			stats.update_stat(stat_utils.stats.ITEMS_DISCOUNT, current_stats)
		Upgrades_Utils.upgrades.EXPLOSION_DAMAGE_UP:    
			var current_stats = stats.get_stat(stat_utils.stats.EXPLOSION_DAMAGE)
			current_stats += 1
			stats.update_stat(stat_utils.stats.EXPLOSION_DAMAGE, current_stats)
		Upgrades_Utils.upgrades.EXPLOSION_DAMAGE_DOWN:
			var current_stats = stats.get_stat(stat_utils.stats.EXPLOSION_DAMAGE)
			current_stats -= 1
			stats.update_stat(stat_utils.stats.EXPLOSION_DAMAGE, current_stats)
		Upgrades_Utils.upgrades.EXPLOSION_RADIUS_UP:
			var current_stats = stats.get_stat(stat_utils.stats.EXPLOSION_RADIUS)
			current_stats += 1
			stats.update_stat(stat_utils.stats.EXPLOSION_RADIUS, current_stats)
		Upgrades_Utils.upgrades.EXPLOSION_RADIUS_DOWN:
			var current_stats = stats.get_stat(stat_utils.stats.EXPLOSION_RADIUS)
			current_stats -= 1
			stats.update_stat(stat_utils.stats.EXPLOSION_RADIUS, current_stats)
		Upgrades_Utils.upgrades.PIERCING_UP:
			var current_stats = stats.get_stat(stat_utils.stats.PIERCING)
			current_stats += 1
			stats.update_stat(stat_utils.stats.PIERCING, current_stats)
		Upgrades_Utils.upgrades.PIERCING_DOWN:
			var current_stats = stats.get_stat(stat_utils.stats.PIERCING)
			current_stats -= 1
			stats.update_stat(stat_utils.stats.PIERCING, current_stats)
		Upgrades_Utils.upgrades.FREE_REROLL_UP:
			var current_stats = stats.get_stat(stat_utils.stats.FREE_REROLL)
			current_stats += 1
			stats.update_stat(stat_utils.stats.FREE_REROLL, current_stats)
		Upgrades_Utils.upgrades.FREE_REROLL_DOWN:
			var current_stats = stats.get_stat(stat_utils.stats.FREE_REROLL)
			current_stats -= 1
			stats.update_stat(stat_utils.stats.FREE_REROLL, current_stats)
		Upgrades_Utils.upgrades.LUCK_UP:
			var current_stats = stats.get_stat(stat_utils.stats.LUCK)
			current_stats += 1
			stats.update_stat(stat_utils.stats.LUCK, current_stats)
		Upgrades_Utils.upgrades.LUCK_DOWN:
			var current_stats = stats.get_stat(stat_utils.stats.LUCK)
			current_stats -= 1
			stats.update_stat(stat_utils.stats.LUCK, current_stats)
		Upgrades_Utils.upgrades.REMAINING_BALLS_UP:
			var current_stats = stats.get_stat(stat_utils.stats.REMAINING_BALLS)
			current_stats += 1
			stats.update_stat(stat_utils.stats.REMAINING_BALLS, current_stats)
		Upgrades_Utils.upgrades.REMAINING_BALLS_DOWN:   
			var current_stats = stats.get_stat(stat_utils.stats.REMAINING_BALLS)
			current_stats -= 1
			stats.update_stat(stat_utils.stats.REMAINING_BALLS, current_stats)
		Upgrades_Utils.upgrades.MAX_BALLS_UP:
			var current_stats = stats.get_stat(stat_utils.stats.MAX_BALLS)
			current_stats += 1
			stats.update_stat(stat_utils.stats.MAX_BALLS, current_stats)
		Upgrades_Utils.upgrades.MAX_BALLS_DOWN:
			var current_stats = stats.get_stat(stat_utils.stats.MAX_BALLS)
			current_stats -= 1
			stats.update_stats(stat_utils.stats.MAX_BALLS, current_stats)
		_:
			push_error("Unknown upgrade: %s" % str(upgrade_to_apply))
			return
	print("Applied upgrade: %s" % str(upgrade_to_apply))
