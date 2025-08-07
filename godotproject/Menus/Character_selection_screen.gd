extends Node2D

var selectedBall: PalleManager.BallType
var selectedBackground: BackgroundManager.BackgroundType
var selectedFlipper: FlipperManager.FlipperType
var levelDataHandoff: LevelDataHandoff = LevelDataHandoff.new()

func get_data():
	levelDataHandoff.setBall(selectedBall)
	levelDataHandoff.setBackground(selectedBackground)
	levelDataHandoff.setFlipper(selectedFlipper)
	return levelDataHandoff

func _ready() -> void:
	#wait 5 seconds before switching scenes
	await get_tree().create_timer(5.0).timeout
	selectedBall = PalleManager.BallType.STANDARD
	selectedBackground = BackgroundManager.BackgroundType.TEST
	selectedFlipper = FlipperManager.FlipperType.STANDARD
	SceneManager.swap_scenes("res://Gameplay/Gameplay.tscn", get_tree().root, self, Transitions.Type.WIPE_TO_RIGHT)
