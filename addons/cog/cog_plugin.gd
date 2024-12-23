@tool
extends EditorPlugin


func _enter_tree():
	add_autoload_singleton("VideoSettings", "res://addons/cog/autoloads/video_settings.tscn")
	add_autoload_singleton("AudioSettings", "res://addons/cog/autoloads/audio_settings.gd")
	add_autoload_singleton("InputSettings", "res://addons/cog/autoloads/input_settings.gd")


func _exit_tree():
	remove_autoload_singleton("VideoSettings")
	remove_autoload_singleton("AudioSettings")
	remove_autoload_singleton("InputSettings")
