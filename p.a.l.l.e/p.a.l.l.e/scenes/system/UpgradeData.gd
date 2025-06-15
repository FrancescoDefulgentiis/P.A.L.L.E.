class_name UpgradeData
extends Resource

# Basic upgrade information
@export var id: String
@export var name: String
@export var description: String
@export var cost: int

# Visual elements
@export var icon: Texture2D
@export var rarity: Rarity

# Gameplay effects
@export var effect_type: EffectType
@export var effect_value: float
@export var duration: float = -1.0  # -1 means permanent

# Constraints
@export var max_stack: int = 1  # How many times can this upgrade be purchased
@export var prerequisites: Array[String] = []  # Required upgrade IDs

enum Rarity {
	COMMON,
	RARE,
	LEGENDARY
}

enum EffectType {
	FLIPPER_SPEED,
	BALL_GRAVITY,
	SCORE_MULTIPLIER,
	EXTRA_BALL,
	MAGNET_STRENGTH,
	BUMPER_POWER
}

func _init(
	p_id: String = "",
	p_name: String = "",
	p_description: String = "",
	p_cost: int = 100,
	p_effect_type: EffectType = EffectType.SCORE_MULTIPLIER,
	p_effect_value: float = 1.0
):
	id = p_id
	name = p_name
	description = p_description
	cost = p_cost
	effect_type = p_effect_type
	effect_value = p_effect_value
