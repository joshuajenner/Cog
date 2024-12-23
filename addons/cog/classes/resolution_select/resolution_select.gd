class_name ResolutionSelect
extends OptionButton


# Edit supported resolutions here
var _resolutions: Array[Vector2i] = [
	Vector2i(1920, 1080),
	Vector2i(1360, 768),
	Vector2i(1280, 720)
]


func _ready():
	_setup_options()
	_on_settings_loaded()
	
	item_selected.connect(_on_item_selected)
	VideoSettings.settings_loaded.connect(_on_settings_loaded)


func _on_item_selected(index: int) -> void:
	VideoSettings.set_resolution(_resolutions[index])


func _setup_options() -> void:
	for i: int in _resolutions.size():
		add_item(_res_string(_resolutions[i]))


func _on_settings_loaded() -> void:
	var selected_resolution: Vector2i = VideoSettings.get_resolution()
	var selected_index: int = -1
	
	for i: int in _resolutions.size():
		if _resolutions[i] == selected_resolution:
			selected_index = i
	
	selected = selected_index


func _res_string(vec: Vector2i) -> String:
	var format: String = "%s x %s"
	return format % [vec.x, vec.y]
