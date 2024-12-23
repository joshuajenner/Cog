class_name KeyBindButton
extends Button


const _WARNING_ACTION: String = "This Key Bind Button does not have a valid Action."
const _WARNING_CANCEL: String = "This Key Bind Button does not have a valid Cancel Action."
const _WARNING_DELETE: String = "This Key Bind Button does not have a valid Delete Action."

@export var action: String
@export var index: int
@export var editing_text: String
@export var cancel_action: String
@export var delete_action: String
@export var key_label_set: KeyLabelSet
@export var mouse_label_set: MouseLabelSet

var _is_editing: bool = false


func _ready() -> void:
	assert(InputMap.has_action(action), _WARNING_ACTION)
	assert(InputMap.has_action(cancel_action), _WARNING_CANCEL)
	assert(InputMap.has_action(delete_action), _WARNING_DELETE)
	set_ready()
	
	pressed.connect(_on_pressed)
	InputSettings.settings_changed.connect(_on_settings_changed)
	InputSettings.editing_text_changed.connect(_on_editing_text_changed)
	InputSettings.key_label_set_changed.connect(set_key_label_set)
	InputSettings.mouse_label_set_changed.connect(set_mouse_label_set)


func set_ready() -> void:
	text = _get_event_text()
	_is_editing = false


func set_editing() -> void:
	text = editing_text
	_is_editing = true


func set_key_label_set(set: KeyLabelSet) -> void:
	key_label_set = set
	set_ready()


func set_mouse_label_set(set: MouseLabelSet) -> void:
	mouse_label_set = set
	set_ready()


func _input(event: InputEvent) -> void:
	if _is_editing:
		if event.is_action_pressed(cancel_action):
			set_ready()
		elif event.is_action_pressed(delete_action):
			_unassign_event(index)
		elif _is_assignable(event):
			get_viewport().set_input_as_handled()
			_assign_event(event)


func _assign_event(event: InputEvent) -> void:
	InputSettings.assign_event(action, event, index)
	set_ready()


func _unassign_event(index: int) -> void:
	InputSettings.unassign_event(action, index)
	_is_editing = false
	set_ready()


func _is_assignable(event: InputEvent) -> bool:
	if event is InputEventMouseButton or event is InputEventKey:
		return true
	
	return false


func _get_event_text() -> String:
	var events: Array[InputEvent] = InputMap.action_get_events(action)
	var event: InputEvent = null
	var event_text: String = ""
	
	if index < events.size():
		event = events[index]
	
	if event != null:
		if event is InputEventKey:
			if key_label_set != null:
				event_text = key_label_set.get_label(event)
			else:
				event_text = OS.get_keycode_string(_get_keycode(event))
		elif event is InputEventMouseButton and mouse_label_set != null:
			event_text = mouse_label_set.get_label(event)
		else:
			event_text = event.as_text()
	
	return event_text


func _get_keycode(event: InputEventKey) -> int:
	var physical_keycode: int = DisplayServer.keyboard_get_keycode_from_physical(event.physical_keycode)
	return max(event.keycode, physical_keycode)


func _on_pressed() -> void:
	if not _is_editing:
		set_editing()


func _on_settings_changed() -> void:
	set_ready()


func _on_editing_text_changed(text: String) -> void:
	editing_text = text
