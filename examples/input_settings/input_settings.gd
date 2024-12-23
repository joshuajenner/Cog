extends MarginContainer


@export var key_label_set: KeyLabelSet
@export var mouse_label_set: MouseLabelSet


func _ready() -> void:
	InputSettings.key_label_set_changed.emit(key_label_set)
	InputSettings.mouse_label_set_changed.emit(mouse_label_set)


func _on_reset_pressed() -> void:
	InputSettings.load_defualt_settings()


func _on_save_pressed() -> void:
	InputSettings.save_user_settings()
