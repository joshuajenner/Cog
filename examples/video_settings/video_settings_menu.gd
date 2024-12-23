extends MarginContainer


func _on_reset_button_pressed() -> void:
	VideoSettings.load_default_settings()


func _on_save_button_pressed() -> void:
	VideoSettings.save_user_settings()
