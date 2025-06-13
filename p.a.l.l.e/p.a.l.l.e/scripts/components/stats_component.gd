class_name StatsComponent extends Node2D

const stats_utils = preload("res://scripts/utils/stats_utils.gd")

@export var currentStats: Dictionary = {
	stats_utils.stats.BALL_BOUNCE: 0.2,       # bounce from godot engine
	stats_utils.stats.BALL_SIZE: 0,                 # Steps like -3, -2, -1, 0, 1, 2, 3
	stats_utils.stats.BALL_DAMAGE_TO_ENEMIES: 0,    # Percentage of extra damage to enemies
	stats_utils.stats.BALL_DAMAGE_TO_STRUCTURES: 0, # Percentage of extra damage to structures
	stats_utils.stats.BALL_DAMAGE_TO_BOSSES: 0,     # Percentage of extra damage to bosses
	stats_utils.stats.BALL_DAMAGE: 10,              # Damage per hit to enemies
	stats_utils.stats.BALL_ELEMENTAL_DAMAGE: 0,     # Elemental damage per hit to enemies
	stats_utils.stats.BALL_KNOCKBACK: 10,           # Knockback force applied to enemies
	stats_utils.stats.BALL_CRITICAL_HIT_CHANCE: 5,  # Chance to deal critical damage
	stats_utils.stats.BALL_HEALTH: 100,             # Health of the ball
	stats_utils.stats.BALL_HEALTH_REGEN: 0.5,       # percentage of health regen per second
	stats_utils.stats.FLIPPER_SPEED: 0,             # Percentage of speed increase     
	stats_utils.stats.FLIPPER_PRECISION: 0,         # Reduction of the cone of error in steps like -3, -2, -1, 0, 1, 2, 3 
	stats_utils.stats.BUMPER_EXPANSION_SPEED: 0,    # Percentage of speed increase
	stats_utils.stats.BUMPER_PRECISION: 0,          # Reduction of the cone of error in steps like -3, -2, -1, 0, 1, 2, 3
	stats_utils.stats.XP_GAIN: 0,                   # Percentage of XP gain
	stats_utils.stats.PICKUP_RANGE: 5,              # Percentage difference between ball collision box and pickup Area2D dimensions
	stats_utils.stats.ITEMS_DISCOUNT: 0,            # Percentage of discount on items
	stats_utils.stats.EXPLOSION_DAMAGE: 10,         # Damage of the explosion 
	stats_utils.stats.EXPLOSION_RADIUS: 100,        # Radius of the explosion
	stats_utils.stats.PIERCING: 0,                  # Boolean value 
	stats_utils.stats.FREE_REROLL: 0,               # Boolean value
	stats_utils.stats.LUCK: 0,                      # TBD
	stats_utils.stats.REMAINING_BALLS: 3,           # Number of balls remaining
	stats_utils.stats.MAX_BALLS: 4                  # Maximum number of balls
}

func get_stat(stat_name: stats_utils.stats) -> int:
	if not currentStats.has(stat_name):
		return 0
	return currentStats[stat_name]

func update_stat(stat_name: stats_utils.stats, value: int) -> void:
	if not currentStats.has(stat_name):
		push_error("Invalid stat name: %s" % stat_name)
		return
	currentStats[stat_name] = value
	print("Updated stat: %s to %d" % [stat_name, value])

func reset_all_stats() -> void:
	for stat in stats_utils.stats.keys():
		currentStats[stat] = stats_utils.DEFAULT_VALUES[stat]
		# Update the UI or any other necessary components
