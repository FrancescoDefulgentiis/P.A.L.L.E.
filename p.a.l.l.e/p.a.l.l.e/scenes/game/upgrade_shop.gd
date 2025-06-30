extends Control

@onready var energy_label = $VBoxContainer/EnergyDisplay
@onready var upgrades_container = $VBoxContainer/UpgradesContainer

func _ready():
	get_tree().paused = true
	
	update_energy_display()
	populate_upgrades()
	
	UpgradeManager.upgrade_purchased.connect(_on_upgrade_purchased)

func _exit_tree():
	get_tree().paused = false

func update_energy_display():
	energy_label.text = "Energia: " + str(UpgradeManager.energy_points)

func populate_upgrades():
	for upgrade in UpgradeManager.available_upgrades:
		var button = create_upgrade_button(upgrade)
		upgrades_container.add_child(button)
