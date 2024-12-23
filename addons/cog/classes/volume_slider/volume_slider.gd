class_name VolumeSlider
extends HSlider


const _WARNING: String = "This Volume Slider does not have a valid Audio Bus."

@export var audio_bus: String

var _bus_index: int = -1


func _ready() -> void:
	_bus_index = AudioServer.get_bus_index(audio_bus)
	assert(_bus_index != -1, _WARNING);
	
	_setup_slider()
	_on_settings_loaded()
	
	drag_ended.connect(_on_drag_ended)
	AudioSettings.settings_loaded.connect(_on_settings_loaded)


func _setup_slider() -> void:
	max_value = 1
	step = 0.01


func _on_drag_ended(value_changed: bool) -> void:
	if value_changed:
		AudioSettings.set_bus_volume(_bus_index, value)


func _on_settings_loaded() -> void:
	value = AudioSettings.get_bus_volume(_bus_index)
