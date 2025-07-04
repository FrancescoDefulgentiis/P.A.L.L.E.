class_name LoadingScreen extends Node2D

signal transition_in_complete

@onready var progress_bar: ProgressBar = %ProgressBar
@onready var anim_player: AnimationPlayer = %AnimationPlayer
@onready var timer: Timer = $Timer

var starting_animation_name:Transitions.Type

func _ready() -> void:
	# Loading screens are so fast there's no need to show the progress bar from the beginning
	progress_bar.visible = false 
	pass
	
func start_transition(animation_name:Transitions.Type) -> void: 
	if !anim_player.has_animation(Transitions.get_String_from_type(animation_name)):
		push_warning("'%s' animation does not exist" % animation_name)
		animation_name = Transitions.Type.FADE_TO_BLACK
		
	starting_animation_name = animation_name
	anim_player.play(Transitions.get_String_from_type(animation_name))
	
	timer.start()
	
func finish_transition() -> void:
	if timer:
		timer.stop()

	var ending_animation_name:Transitions.Type = Transitions.invert_transition(starting_animation_name)
	
	if !anim_player.has_animation(Transitions.get_String_from_type(ending_animation_name)):
		push_warning("'%s' animation does not exist" % ending_animation_name)
		ending_animation_name = Transitions.Type.FADE_FROM_BLACK
	anim_player.play(Transitions.get_String_from_type(ending_animation_name))

	await anim_player.animation_finished
	queue_free()


func report_midpoint() -> void:
	transition_in_complete.emit()

func _on_timer_timeout() -> void:
	progress_bar.visible = true

func update_bar(val:float) -> void:
	progress_bar.value = val
