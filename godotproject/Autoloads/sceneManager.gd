extends Node

signal load_start(loading_screen)	## Triggered when an asset begins loading
signal scene_added(loaded_scene:Node,loading_screen)	## Triggered right after asset is added to SceneTree but before transition animation finishes
signal load_complete(loaded_scene:Node)	## Triggered when loading has completed

signal _content_finished_loading(content)	## internal - triggered when content is loaded and final data handoff and transition out begins
signal _content_invalid(content_path:String)	## internal - triggered when attempting to load invalid content (e.g. an asset does not exist or path is incorrect)
signal _content_failed_to_load(content_path:String)	## internal - triggered when loading has started but failed to complete

var _loading_screen_scene:PackedScene = preload("res://Menus/loading_screen.tscn")
var _loading_screen:LoadingScreen
var _transition:Transitions.Type
var _content_path:String
var _load_progress_timer:Timer
var _load_scene_into:Node
var _scene_to_unload:Node  
var _loading_in_progress:bool = false

func _ready() -> void:
	_content_invalid.connect(_on_content_invalid)
	_content_failed_to_load.connect(_on_content_failed_to_load)
	_content_finished_loading.connect(_on_content_finished_loading)

## [b][color=plum]scene_to_load[/color][/b] - [String] path to the resource you'd like to load[br]
## [b][color=plum]load_into[/color][/b] - [Node] Node you'd like to load the resource into[br]
## [b][color=plum]scene_to_unload[/color][/b] - [Node] scene you're unloading, leave null to skip unloading step
## [b][color=plum]transition_type[/color][/b] - [String] name of transition
func swap_scenes(scene_to_load:String, load_into:Node=null, scene_to_unload:Node=null, transition_type:Transitions.Type = Transitions.Type.FADE_TO_BLACK) -> void:

	if _loading_in_progress:
		push_warning("SceneManager is already loading something")
		return
	
	_loading_in_progress = true
	if load_into == null: load_into = get_tree().root
	_load_scene_into = load_into
	_scene_to_unload = scene_to_unload
	
	_add_loading_screen(transition_type)
	load_start.emit(_loading_screen)
		
	var loader = ResourceLoader.load_threaded_request(scene_to_load)
	
	if not ResourceLoader.exists(scene_to_load) or loader == null:
		_content_invalid.emit(scene_to_load)
		return 		
	
	_load_progress_timer = Timer.new()
	_load_progress_timer.wait_time = 0.1
	_load_progress_timer.timeout.connect(_monitor_load_status)
	
	get_tree().root.add_child(_load_progress_timer)
	_load_progress_timer.start()

func _add_loading_screen(transition_type:Transitions.Type=Transitions.Type.FADE_TO_BLACK):
	_transition = Transitions.Type.NO_TRANSITION
	_loading_screen = _loading_screen_scene.instantiate() as LoadingScreen
	get_tree().root.add_child(_loading_screen)
	_loading_screen.start_transition(_transition)
	
func _monitor_load_status() -> void:
	var load_progress = []
	var load_status = ResourceLoader.load_threaded_get_status(_content_path, load_progress)

	match load_status:
		ResourceLoader.THREAD_LOAD_INVALID_RESOURCE:
			_content_invalid.emit(_content_path)
			_load_progress_timer.stop()
			return
		ResourceLoader.THREAD_LOAD_IN_PROGRESS:
			if _loading_screen != null:
				_loading_screen.update_bar(load_progress[0] * 100) # 0.1
		ResourceLoader.THREAD_LOAD_FAILED:
			_content_failed_to_load.emit(_content_path)
			_load_progress_timer.stop()
			return
		ResourceLoader.THREAD_LOAD_LOADED:
			_load_progress_timer.stop()
			_load_progress_timer.queue_free()
			_content_finished_loading.emit(ResourceLoader.load_threaded_get(_content_path).instantiate())
			return

func _on_content_failed_to_load(path:String) -> void:
	printerr("error: Failed to load resource: '%s'" % [path])	

func _on_content_invalid(path:String) -> void:
	printerr("error: Cannot load resource: '%s'" % [path])
	
func _on_content_finished_loading(incoming_scene) -> void:
	var outgoing_scene = _scene_to_unload
	
	if outgoing_scene != null:	
		if outgoing_scene.has_method("get_data") and incoming_scene.has_method("receive_data"):
			incoming_scene.receive_data(outgoing_scene.get_data())
	
	_load_scene_into.add_child(incoming_scene)
	scene_added.emit(incoming_scene,_loading_screen)
	
	if _scene_to_unload != null:
		if _scene_to_unload != get_tree().root: 
			_scene_to_unload.queue_free()
	
	if incoming_scene.has_method("init_scene"): 
		incoming_scene.init_scene()
	
	if _loading_screen != null:
		_loading_screen.finish_transition()
		
		await _loading_screen.anim_player.animation_finished

	if incoming_scene.has_method("start_scene"): 
		incoming_scene.start_scene()
	
	_loading_in_progress = false
	load_complete.emit(incoming_scene)
