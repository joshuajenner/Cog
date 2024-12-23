extends Node


signal settings_changed
signal settings_loaded

const _SECTION: String = "video_settings"
const _WINDOW_MODE_KEY: String = "window_mode"
const _RESOLUTION_KEY: String = "resolution"

@export var _window_mode: DisplayServer.WindowMode
@export var _resolution: Vector2i


func _ready() -> void:
	_save_default_settings()
	
	var config: ConfigFile = ConfigFile.new()
	var load_user_settings: Error = config.load(Cog.VIDEO_SETTINGS_USER_PATH)
	
	if load_user_settings == OK:
		_apply_config(config)
	else:
		save_user_settings()


func load_default_settings() -> void:
	_load_settings(Cog.VIDEO_SETTINGS_DEFAULT_PATH)


func load_user_settings() -> void:
	_load_settings(Cog.VIDEO_SETTINGS_USER_PATH)


func save_user_settings() -> void:
	_save_settings(Cog.VIDEO_SETTINGS_USER_PATH)


func set_resolution(value: Vector2i) -> void:
	_resolution = value
	get_window().size = value
	get_window().move_to_center()
	
	settings_changed.emit()


func get_resolution() -> Vector2i:
	return _resolution


func set_window_mode(value: DisplayServer.WindowMode) -> void:
	_window_mode = value
	DisplayServer.window_set_mode(value)
	get_window().move_to_center()
	
	settings_changed.emit()


func get_window_mode() -> DisplayServer.WindowMode:
	return _window_mode


func _apply_config(config: ConfigFile) -> void:
	set_window_mode(config.get_value(_SECTION, _WINDOW_MODE_KEY))
	set_resolution(config.get_value(_SECTION, _RESOLUTION_KEY))
	 
	settings_loaded.emit()
	settings_changed.emit()


func _load_settings(path: String) -> void:
	var config: ConfigFile = ConfigFile.new()
	var load_settings: Error = config.load(path)
	
	if load_settings == OK:
		_apply_config(config)


func _save_default_settings() -> void:
	_save_settings(Cog.VIDEO_SETTINGS_DEFAULT_PATH)


func _save_settings(path: String) -> void:
	var config: ConfigFile = ConfigFile.new()
	config.set_value(_SECTION, _WINDOW_MODE_KEY, _window_mode)
	config.set_value(_SECTION, _RESOLUTION_KEY, _resolution)
	
	config.save(path)
