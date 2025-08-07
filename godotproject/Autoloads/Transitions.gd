extends Node

enum Type {
	FADE_TO_BLACK,
	FADE_FROM_BLACK,
	FADE_TO_WHITE,
	FADE_FROM_WHITE,
	WIPE_TO_RIGHT,
	WIPE_FROM_RIGHT,
	NO_TRANSITION
}

const NAMES = {
	Type.FADE_TO_BLACK: "fade_to_black",
	Type.FADE_FROM_BLACK: "fade_from_black",
	Type.FADE_TO_WHITE: "fade_to_white",
	Type.FADE_FROM_WHITE: "fade_from_white",
	Type.WIPE_TO_RIGHT: "wipe_to_right",
	Type.WIPE_FROM_RIGHT: "wipe_from_right",
	Type.NO_TRANSITION: "no_to_transition"
}

const STRING_TO_ENUM = {
	"fade_to_black": Type.FADE_TO_BLACK,
	"fade_from_black": Type.FADE_FROM_BLACK,
	"fade_to_white": Type.FADE_TO_WHITE,
	"fade_from_white": Type.FADE_FROM_WHITE,
	"wipe_to_right": Type.WIPE_TO_RIGHT,    
	"wipe_from_right": Type.WIPE_FROM_RIGHT,                                    
	"no_transition": Type.NO_TRANSITION
}

const DEFAULT = Type.FADE_TO_BLACK

func get_all_names() -> Array[String]:
	return NAMES.values()

func get_all_types() -> Array[Type]:
	var types: Array[Type] = []
	for type in Type.values():
		types.append(type)
	return types

func is_valid_name(transition_name: String) -> bool:
	return transition_name in STRING_TO_ENUM

func is_valid_type(transition_type: Type) -> bool:
	return transition_type in NAMES

func from_string(transition_name: String) -> Type:
	return STRING_TO_ENUM.get(transition_name, DEFAULT)

func get_String_from_type(transition_type: Type) -> String:
	return NAMES.get(transition_type, NAMES[DEFAULT])

func get_random() -> Type:
	var types = get_all_types()
	types.erase(Type.NO_TRANSITION)
	return types[randi() % types.size()]

func invert_transition(transition_type: Type) -> Type:
	match transition_type:
		Type.FADE_TO_BLACK:
			return Type.FADE_FROM_BLACK
		Type.FADE_TO_WHITE:
			return Type.FADE_FROM_WHITE
		Type.WIPE_TO_RIGHT:
			return Type.WIPE_FROM_RIGHT
		Type.NO_TRANSITION:
			return Type.NO_TRANSITION
		_:
			return transition_type

func get_random_name() -> String:
	return get_String_from_type(get_random())
