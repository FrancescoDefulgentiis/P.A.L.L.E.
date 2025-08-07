class_name LevelDataHandoff extends Node

var background: BackgroundManager.BackgroundType
var ball: PalleManager.BallType
var flipper: FlipperManager.FlipperType

#-----Setters------#
func setBackground(selectedBackground: BackgroundManager.BackgroundType):
	background = selectedBackground
	
func setBall(selectedBall: PalleManager.BallType):
	ball = selectedBall

func setFlipper(selectedFlipper: FlipperManager.FlipperType):
	flipper = selectedFlipper

#-----Getters------#
func getBackground() -> BackgroundManager.BackgroundType:
	return background

func getBall() -> PalleManager.BallType:
	return ball
	
func getFlipper() -> FlipperManager.FlipperType:
	return flipper
