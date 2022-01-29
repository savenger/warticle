extends Node

const LEVEL_PATH: String = 'res://Scenes/Levels'
const MAX_ENTRY_COUNT: int = 6
var tutorial_levels: Array = []

var rng = RandomNumberGenerator.new()

# global level map which indicates where the levels have an entry
# the key is the index of the entry (e.g. 0 is the first "row", 1 the second "row"...)
var level_entry_map: Dictionary = {}

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	for i in range(Globals.TUTORIAL_LEVEL_COUNT):
		tutorial_levels.append("res://Scenes/Levels/tutorial%d.tscn" % (i + 1))
	rng.randomize()
	init_levels()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _add_dir_contents(dir: Directory, files: Array, directories: Array):
	var file_name = dir.get_next()

	while (file_name != ""):
		var path = dir.get_current_dir() + "/" + file_name

		if dir.current_is_dir():
			#print("Found directory: %s" % path)
			var subDir = Directory.new()
			subDir.open(path)
			subDir.list_dir_begin(true, false)
			directories.append(path)
			_add_dir_contents(subDir, files, directories)
		else:
			#print("Found file: %s" % path)
			files.append(path)

		file_name = dir.get_next()

	dir.list_dir_end()

func get_dir_contents(path: String) -> Array:
	var files = []
	var directories = []
	var dir = Directory.new()

	if dir.open(path) == OK:
		dir.list_dir_begin(true, false)
		_add_dir_contents(dir, files, directories)
	else:
		push_error("An error occurred when trying to access the path.")

	return [files, directories]

# loads all levels and saves them into the global level map
func init_levels():
	for level in get_dir_contents(LEVEL_PATH)[0]:
		var entries = get_entries(level)
		var index = 0
		for entry in entries:
			if entry == 1:
				#print("Saving ", level, " into index ", index)
				if not level_entry_map.has(index):
					level_entry_map[index] = []
				level_entry_map[index].append(level)
			index += 1

# returns an array of 0s and 1s indicating whether theres an entry (1) or not (0) 
# on the "i"s row, where i is the index of the array
func get_entries(level) -> Array:
	var ret = []
	var entries: String = level.substr(LEVEL_PATH.length() + "/level_".length(), MAX_ENTRY_COUNT)
	for i in entries.length():
		ret.append(int(entries[i]))
	return ret

# returns an array of 0s and 1s indicating whether theres an exit (1) or not (0) 
# on the "i"s row, where i is the index of the array
func get_exits(level) -> Array:
	var ret = []
	var exits: String = level.substr(LEVEL_PATH.length() + "/level_".length() + MAX_ENTRY_COUNT + "_".length(), MAX_ENTRY_COUNT)
	for i in exits.length():
		ret.append(int(exits[i]))
	return ret

func first_level():
	return tutorial_levels[0]

func load_next_level(level) -> String:
	if level in tutorial_levels:
		if tutorial_levels[len(tutorial_levels) - 1] == level:
			Globals.in_tutorial_level = false
			Globals.scroll_speed *= 2
			return level_entry_map[3][0]
		# return next tutorial level
		var index = tutorial_levels.find(level)
		return tutorial_levels[Globals.tutorial_level]
	print("Connecting level ", level)
	var exits = get_exits(level)
	var possible_exits = []
	var index = 0;
	for exit in exits:
		if exit == 1:
			possible_exits.append(index)
		index += 1
	# print("possible_exits: ", possible_exits)
	var rnd_exit = rng.randi_range(0, len(possible_exits) - 1)
	rnd_exit = possible_exits[rnd_exit]
	var rnd_entry_level = rng.randi_range(0, len(level_entry_map[rnd_exit]) - 1)
	print(" ... to level ", level_entry_map[rnd_exit][rnd_entry_level])
	return(level_entry_map[rnd_exit][rnd_entry_level])

func random_level():
	var entry = rng.randi_range(0, MAX_ENTRY_COUNT - 1)
	var level = rng.randi_range(0, len(level_entry_map[entry]) - 1)
	return(level_entry_map[entry][level])
