extends Node

const GRAVITY: int = 5000
const LEVEL_WIDTH: int = 1920
const TUTORIAL_LEVEL_COUNT: int = 6

var music_volume: float = -30.0
var sfx_volume: float = -30.0
var scroll_speed: int = 250
var applyed_scroll_speed: int = 250 # the actual speed of the scrolling
var tutorial_level: int = 0
var in_tutorial_level: bool = true
var score: int = 0
var highscores = []

func _ready():
	set_music_volume(music_volume)
	set_sfx_volume(sfx_volume)

func set_master_volume(new_volume):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), new_volume)

func set_music_volume(new_volume):
	print("setting %d" % new_volume)
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Music"), new_volume)
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("ARP"), new_volume)
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Synth"), new_volume)
	
func set_sfx_volume(new_volume):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("SFX"), new_volume)
