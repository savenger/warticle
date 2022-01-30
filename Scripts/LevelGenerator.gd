extends Node

const LEVEL_PATH: String = 'res://Scenes/Levels'
const SLICE_PATH: String = 'res://Scenes/Slices'
const MAX_ENTRY_COUNT: int = 6
const MAX_BOXES = 11
var tutorial_levels: Array = []

var rng = RandomNumberGenerator.new()

# global level map which indicates where the levels have an entry
# the key is the index of the entry (e.g. 0 is the first "row", 1 the second "row"...)
var level_entry_map: Dictionary = {}
var slice_entry_map: Dictionary = {}

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	for i in range(Globals.TUTORIAL_LEVEL_COUNT):
		tutorial_levels.append("res://Scenes/Levels/tutorial%d.tscn" % (i + 1))
	rng.randomize()
	init_levels()
	init_slices()

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
func init_slices():
	for level in get_dir_contents(SLICE_PATH)[0]:
		var entries = get_slice_entries(level)
		var index = 0
		for entry in entries:
			if entry == 1:
				#print("Saving ", level, " into index ", index)
				if not slice_entry_map.has(index):
					slice_entry_map[index] = []
				slice_entry_map[index].append(level)
			index += 1

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
func get_slice_entries(slice) -> Array:
	var ret = []
	var entries: String = slice.substr(SLICE_PATH.length() + "/slice_XX_X_X_".length(), MAX_ENTRY_COUNT)
	for i in entries.length():
		ret.append(int(entries[i]))
	return ret

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
func get_slice_exits(slice) -> Array:
	var ret = []
	var exits: String = slice.substr(SLICE_PATH.length() + "/slice_XX_X_X_".length() + MAX_ENTRY_COUNT + "_".length(), MAX_ENTRY_COUNT)
	for i in exits.length():
		ret.append(int(exits[i]))
	return ret

func get_slice_boxes(slice) -> int:
	var boxes: String = slice.substr(SLICE_PATH.length() + "/slice_XX_X_".length(), 1)
	return int(boxes)

# returns an array of 0s and 1s indicating whether theres an exit (1) or not (0) 
# on the "i"s row, where i is the index of the array
func get_exits(level) -> Array:
	var ret = []
	var exits: String = level.substr(LEVEL_PATH.length() + "/level_".length() + MAX_ENTRY_COUNT + "_".length(), MAX_ENTRY_COUNT)
	for i in exits.length():
		ret.append(int(exits[i]))
	return ret

func first_level():
	return level_entry_map[0][0]

func first_tutorial_level():
	return tutorial_levels[0]

func first_slices():
	return ["res://Scenes/Slices/slice_A4_3_1_111100_111100.tscn"]

func extract_possible_exits(exits) -> Array:
	var possible_exits = []
	var index = 0;
	for exit in exits:
		if exit == 1:
			possible_exits.append(index)
		index += 1
	return possible_exits

func get_random_element(arr):
	var index = rng.randi_range(0, len(arr) - 1)
	return arr[index]

func load_next_level(level) -> String:
	if level in tutorial_levels:
		if Globals.in_tutorial_level:
			if tutorial_levels[len(tutorial_levels) - 1] == level:
				Globals.in_tutorial_level = false
				Globals.scroll_speed *= 2
				return tutorial_levels[0]
		else:
			# this will happen directly after finishing the tutorial 
			# (player is in first tutorial level again)
			return(level_entry_map[3][0])
		# return next tutorial level
		#var index = tutorial_levels.find(level)
		#if index == 0:
		return tutorial_levels[Globals.tutorial_level]
		#else:
		#	return tutorial_levels[0]
	# print("Connecting level ", level)
	var exits = get_exits(level)
	var possible_exits = extract_possible_exits(exits)
	var rnd_exit = get_random_element(possible_exits)
	var rnd_entry_level = rng.randi_range(0, len(level_entry_map[rnd_exit]) - 1)
	# print(" ... to level ", level_entry_map[rnd_exit][rnd_entry_level])
	return(level_entry_map[rnd_exit][rnd_entry_level])

func load_next_level_sliced(slices) -> Array:
	# get exits of last slice
	var exits = get_slice_exits(slices[len(slices) - 1])
	var ret_slices: Array = []
	var boxes: int = 0
	var possible_exits
	var rnd_exit
	var rnd_entry_slice
	while boxes < MAX_BOXES:
		possible_exits = extract_possible_exits(exits)
		rnd_exit = get_random_element(possible_exits)
		rnd_entry_slice = get_random_element(slice_entry_map[rnd_exit])
		# get new slice if too big (we need exactly 11 boxes)
		while boxes + get_slice_boxes(rnd_entry_slice) > MAX_BOXES:
			rnd_entry_slice = get_random_element(slice_entry_map[rnd_exit])
		exits = get_slice_exits(rnd_entry_slice)
		ret_slices.append(rnd_entry_slice)
		boxes += get_slice_boxes(rnd_entry_slice)
	return ret_slices

func random_level():
	var entry = rng.randi_range(0, MAX_ENTRY_COUNT - 1)
	var level = rng.randi_range(0, len(level_entry_map[entry]) - 1)
	return(level_entry_map[entry][level])
