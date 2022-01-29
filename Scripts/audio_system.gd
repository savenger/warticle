extends Node2D

func set_music_volume(new_volume):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Music"), new_volume)


func _on_audio_system_sfx_volume(new_volume):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("SFX"), new_volume)


func _on_Button_MusicMute_toggled(button_pressed):
	print("Music: " + str(button_pressed))
	AudioServer.set_bus_mute(AudioServer.get_bus_index("Music"),!button_pressed)


func _on_Button_SFXMute_toggled(button_pressed):
	print("SFX: " + str(button_pressed))
	AudioServer.set_bus_mute(AudioServer.get_bus_index("SFX"),!button_pressed)
