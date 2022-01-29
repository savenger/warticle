extends Node2D

const START_WITH_TUTORIAL: bool = true

var player



# Called when the node enters the scene tree for the first time.
func _ready():
	print(get_parent().name)
	player = get_parent().get_node("rainbow_animation/Player")
	if name == "Level1":
		if START_WITH_TUTORIAL:
			get_parent().current_level = LevelGenerator.first_level()
		else:
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
	move_level(delta)

func move_level(delta):
	var speed = Globals.scroll_speed
	if player.player_state == 1:
		speed = player.player_speed_wave
	position.x -= speed * delta
	if position.x < -Globals.LEVEL_WIDTH:
		Globals.scroll_speed += 1
		position.x += 2 * Globals.LEVEL_WIDTH
		get_parent().current_level = LevelGenerator.load_next_level(get_parent().current_level)
		for child in get_children():
			remove_child(child)
		add_child(load(get_parent().current_level).instance())
