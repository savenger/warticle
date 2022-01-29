extends Node2D

func set_music_volume(new_volume):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Music"), new_volume)


func _on_audio_system_sfx_volume(new_volume):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("SFX"), new_volume)
