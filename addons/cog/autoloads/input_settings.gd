extends Node


signal settings_changed
signal settings_loaded
signal editing_text_changed(text: String)
signal key_label_set_changed(set: KeyLabelSet)
signal mouse_label_set_changed(set: MouseLabelSet)

const _SECTION: String = "keybindings"


func _ready() -> void:
	var config := ConfigFile.new()
	var load_user_settings: Error = config.load(Cog.INPUT_SETTINGS_USER_PATH)
	
	if load_user_settings == OK:
		_apply_config(config)
	else:
		save_user_settings()


func load_defualt_settings() -> void:
	InputMap.load_from_project_settings()

	settings_loaded.emit()
	settings_changed.emit()


func load_user_settings() -> void:
	var config := ConfigFile.new()
	var load_settings: Error = config.load(Cog.INPUT_SETTINGS_USER_PATH)
	
	if load_settings == OK:
		_apply_config(config)


func save_user_settings() -> void:
	var config := ConfigFile.new()
	var actions: Array[StringName] = InputMap.get_actions()
	
	for action: StringName in actions:
		var events: Array[InputEvent] = InputMap.action_get_events(action)
		config.set_value(_SECTION, action, events)
	
	config.save(Cog.INPUT_SETTINGS_USER_PATH)


func assign_event(action: String, event: InputEvent, index: int) -> void:
	var events: Array[InputEvent] = InputMap.action_get_events(action)
	
	if index >= events.size():
		InputMap.action_add_event(action, event)
	else:
		InputMap.action_erase_events(action)

		for i: int in events.size():
			if index == i:
				InputMap.action_add_event(action, event)
			else:
				InputMap.action_add_event(action, events[i])
	
	settings_changed.emit()


func unassign_event(action: String, index: int) -> void:
	var events: Array[InputEvent] = InputMap.action_get_events(action)
	InputMap.action_erase_event(action, events[index])
	
	settings_changed.emit()


func _apply_config(config: ConfigFile) -> void:
	var actions: PackedStringArray = config.get_section_keys(_SECTION)
	
	for action: String in actions:
		var events: Array[InputEvent] = config.get_value(_SECTION, action)
		InputMap.action_erase_events(action)
		
		for event: InputEvent in events:
			InputMap.action_add_event(action, event)
	
	settings_changed.emit()
	settings_loaded.emit()
