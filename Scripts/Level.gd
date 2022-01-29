extends Node2D

const SCROLL_SPEED:int = 10
const WIDTH:int = 1920


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	if name == "Level1":
		get_parent().current_level = LevelGenerator.random_level()
		var parent = get_parent()
		var cur_level = parent.get("current_level")
		var scene = load(cur_level)
		var instance = scene.instance()
		add_child(instance)
	else:
		get_parent().current_level = LevelGenerator.load_next_level(get_parent().current_level)
		add_child(load(get_parent().current_level).instance())


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position.x -= SCROLL_SPEED
	if position.x < -WIDTH:
		position.x += 2 * WIDTH
		get_parent().current_level = LevelGenerator.load_next_level(get_parent().current_level)
		for child in get_children():
			remove_child(child)
		add_child(load(get_parent().current_level).instance())
