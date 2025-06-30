extends Control

@onready var energy_label = $VBoxContainer/EnergyDisplay
@onready var upgrades_container = $VBoxContainer/UpgradesContainer

func _ready():
	# Pausa il gioco mentre il menu è aperto
	get_tree().paused = true
	
	# Aggiorna l'interfaccia
	update_energy_display()
	populate_upgrades()
	
	# Ascolta i segnali dell'UpgradeManager
	UpgradeManager.upgrade_purchased.connect(_on_upgrade_purchased)

func _exit_tree():
	# Riprendi il gioco quando il menu si chiude
	get_tree().paused = false

func update_energy_display():
	energy_label.text = "Energia: " + str(UpgradeManager.energy_points)

func populate_upgrades():
	# Crea un bottone per ogni upgrade disponibile
	for upgrade in UpgradeManager.available_upgrades:
		var button = create_upgrade_button(upgrade)
		upgrades_container.add_child(button)
