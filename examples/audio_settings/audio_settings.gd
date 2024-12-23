extends MarginContainer


func _on_reset_button_pressed() -> void:
	AudioSettings.load_default_settings()


func _on_save_button_pressed() -> void:
	AudioSettings.save_user_settings()
