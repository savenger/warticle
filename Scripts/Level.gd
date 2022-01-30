extends Node2D

const START_WITH_TUTORIAL: bool = true
const acc = 4000

var player

var vel = Globals.scroll_speed

# Called when the node enters the scene tree for the first time.
func _ready():
	player = get_parent().get_node("rainbow_animation/Player")
	if name == "Level1":
		if START_WITH_TUTORIAL:
			get_parent().current_level = LevelGenerator.first_tutorial_level()
		else:
			Globals.in_tutorial_level = false
			get_parent().current_level = LevelGenerator.first_level()
		get_parent().current_slices = [] + LevelGenerator.first_slices()
		var parent = get_parent()
		var cur_level = parent.get("current_level")
		var scene = load(cur_level)
		var instance = scene.instance()
		add_child(instance)

	else:
		get_parent().current_level = LevelGenerator.load_next_level(get_parent().current_level)
		add_child(load(get_parent().current_level).instance())

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	move_level(delta)

func create_scene(slices):
	var scene_path = "res://Scenes/Levels/level.tscn"
	var scene = load(scene_path)
	var root = scene.instance()
	var offset = 0
	for slice in slices:
		# print("adding slice: %s" % slice)
		var boxes = LevelGenerator.get_slice_boxes(slice)
		var slice_scene = load(slice).instance()
		slice_scene.position.x = offset
		root.add_child(slice_scene)
		offset += 180 * boxes
	return root

func move_level(delta):
	var target_speed = Globals.scroll_speed
	if player.player_state == 1:
		target_speed += player.wave_speed
	if player.scroll_speedup:
		target_speed += player.speed
	vel = move_toward(vel, target_speed, delta * acc)
	position.x -= vel * delta
	if position.x < -Globals.LEVEL_WIDTH:
		Globals.scroll_speed += 1
		position.x += 2 * Globals.LEVEL_WIDTH
		if Globals.in_tutorial_level:
			get_parent().current_level = LevelGenerator.load_next_level(get_parent().current_level)
			for child in get_children():
				remove_child(child)
			add_child(load(get_parent().current_level).instance())
		else:
			get_parent().current_slices = LevelGenerator.load_next_level_sliced(get_parent().current_slices)
			for child in get_children():
				remove_child(child)
			add_child(create_scene(get_parent().current_slices))
