extends Node

const GRAVITY: int = 5000
const LEVEL_WIDTH: int = 1920
const TUTORIAL_LEVEL_COUNT: int = 6

var audio_volume: float = -30.0
var scroll_speed: int = 250
var tutorial_level: int = 0
var in_tutorial_level: bool = true

func set_master_volume(new_volume):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), new_volume)

func set_music_volume(new_volume):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Music"), new_volume)
	
func set_sfx_volume(new_volume):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("SFX"), new_volume)
