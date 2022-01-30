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


func _on_Timer_Theme_1_timeout():
	toggle_mute(get_node("ASP_theme_1"))


func toggle_mute(player: AudioStreamPlayer):
	if player.volume_db == Globals.music_volume:
		player.volume_db = -72
	else:
		player.volume_db = Globals.music_volume


func _on_Timer_Sparkles_timeout():
	$ASP_Sparkles.volume_db = Globals.music_volume
	$Timer_Sparkles2.start()


func _on_Timer_Sparkles2_timeout():
	$ASP_Sparkles.volume_db = -72
	$Timer_Sparkles.start()
