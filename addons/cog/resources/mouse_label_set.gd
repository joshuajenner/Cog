class_name MouseLabelSet
extends Resource


@export var NONE : String = ""
@export var MOUSE_LEFT : String = ""
@export var MOUSE_RIGHT : String = ""
@export var MOUSE_MIDDLE : String = ""
@export var WHEEL_UP : String = ""
@export var WHEEL_DOWN : String = ""
@export var WHEEL_LEFT : String = ""
@export var WHEEL_RIGHT : String = ""
@export var XBUTTON1 : String = ""
@export var XBUTTON2 : String = ""


func get_label(event: InputEventMouseButton) -> String:
	var label: String = _get_custom_label(event.button_index)

	if label != "":
		return label

	return event.as_text()


func _get_custom_label(button_index: int) -> String:
	match (button_index):
		MOUSE_BUTTON_NONE:
			return NONE
		MOUSE_BUTTON_LEFT:
			return MOUSE_LEFT
		MOUSE_BUTTON_RIGHT:
			return MOUSE_RIGHT
		MOUSE_BUTTON_MIDDLE:
			return MOUSE_MIDDLE
		MOUSE_BUTTON_WHEEL_UP:
			return WHEEL_UP
		MOUSE_BUTTON_WHEEL_DOWN:
			return WHEEL_DOWN
		MOUSE_BUTTON_WHEEL_LEFT:
			return WHEEL_LEFT
		MOUSE_BUTTON_WHEEL_RIGHT:
			return WHEEL_RIGHT
		MOUSE_BUTTON_XBUTTON1:
			return XBUTTON1
		MOUSE_BUTTON_XBUTTON2:
			return XBUTTON2
		_:
			return ""