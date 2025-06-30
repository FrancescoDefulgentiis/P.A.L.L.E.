extends Node

signal upgrade_purchased(upgrade_id: String)
signal shop_opened()
signal shop_closed()

var energy_points: int = 0
var active_upgrades: Dictionary = {}
var available_upgrades: Array[UpgradeData] = []

func _ready():
	load_upgrade_data()
	generate_upgrade_selection()

func add_energy(amount: int):
	energy_points += amount
	# maybe emit signal here to update UI?

func can_afford_upgrade(upgrade: UpgradeData) -> bool:
	return energy_points >= upgrade.cost

func purchase_upgrade(upgrade_id: String):
	var upgrade = find_upgrade_by_id(upgrade_id)
	if upgrade and can_afford_upgrade(upgrade):
		energy_points -= upgrade.cost
		active_upgrades[upgrade_id] = upgrade
		upgrade_purchased.emit(upgrade_id)
		return true
	return false

func load_upgrade_data():
	var upgrade_files = [
		"res://data/upgrades/faster_flippers.tres",
		"res://data/upgrades/score_multiplier.tres",
		"res://data/upgrades/extra_ball.tres"
	]
	
	var all_upgrades: Array[UpgradeData] = []
	for file_path in upgrade_files:
		var upgrade = load(file_path) as UpgradeData
		if upgrade:
			all_upgrades.append(upgrade)
	
	return all_upgrades

func generate_upgrade_selection():
	var all_upgrades = load_upgrade_data()
	
	available_upgrades.clear()
	all_upgrades.shuffle()
	
	for i in range(min(3, all_upgrades.size())):
		available_upgrades.append(all_upgrades[i])

func find_upgrade_by_id(upgrade_id: String) -> UpgradeData:
	for upgrade in available_upgrades:
		if upgrade.id == upgrade_id:
			return upgrade
	return null
