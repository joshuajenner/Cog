class_name WindowModeSelect
extends OptionButton


# Edit supported Window Modes here
var _window_modes: Dictionary = {
	"Fullscreen": DisplayServer.WindowMode.WINDOW_MODE_EXCLUSIVE_FULLSCREEN,
	"Borderless": DisplayServer.WindowMode.WINDOW_MODE_FULLSCREEN,
	"Windowed": DisplayServer.WindowMode.WINDOW_MODE_WINDOWED
}


func _ready() -> void:
	_setup_options()
	_on_settings_loaded()
	
	item_selected.connect(_on_item_selected)
	VideoSettings.settings_loaded.connect(_on_settings_loaded)


func _setup_options() -> void:
	for key: String in _window_modes.keys():
		add_item(key, _window_modes[key])


func _on_item_selected(index: int) -> void:
	VideoSettings.set_window_mode(get_item_id(index))


func _on_settings_loaded() -> void:
	var window_mode = VideoSettings.get_window_mode()
	
	for i: int in item_count:
		if get_item_id(i) == window_mode:
			select(i)
			break
