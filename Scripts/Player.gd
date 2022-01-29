extends KinematicBody2D

var player_state = 0 # 0: particle, 1: wave

const gravity = Globals.GRAVITY
const speed = 600
const wave_speed = speed * 4
const jump_speed = 2000
const acc = 5000

var vel = Vector2(0,0)
var scroll_speedup = false

func get_input_x():
	var x_speed = Input.get_action_strength("move_right_button") - Input.get_action_strength("move_left_button")
	return x_speed

func finish_tutorial_level(level):
	if not Globals.in_tutorial_level:
		return
	if Globals.tutorial_level == level:
		print("Yeah, you finished level %d" % level)
		if Globals.tutorial_level < Globals.TUTORIAL_LEVEL_COUNT - 1:
			Globals.tutorial_level += 1

func switch_state():
	if player_state == 0:
		finish_tutorial_level(3)
		$Sprite.visible = false
		$Wave.visible = true
		player_state = 1
	else:
		finish_tutorial_level(4)
		$Sprite.visible = true
		$Wave.visible = false
		player_state = 0

func _process(delta):
	finish_tutorial_level(5)
	if Input.is_action_just_pressed("switch_button"):
		switch_state()
	scroll_speedup = self.global_position.x > Globals.LEVEL_WIDTH * 0.9 and Input.is_action_pressed("move_right_button")

func _physics_process(delta):
	if Input.is_action_pressed("volume_up"):
		Globals.audio_volume += 10 * delta
		Globals.set_master_volume(Globals.audio_volume)
	if Input.is_action_pressed("volume_down"):
		Globals.audio_volume -= 10 * delta
		Globals.set_master_volume(Globals.audio_volume)
	if player_state == 0: # particle movement
		if Input.is_action_pressed("move_right_button") or Input.is_action_pressed("move_left_button"):
			finish_tutorial_level(0)
		var input_x = get_input_x()
		var target_speed = input_x * speed * int(!scroll_speedup)
		vel.x = move_toward(vel.x, target_speed, delta * acc)
		vel.y += gravity * delta
		if Input.is_action_pressed("jump_button"):
			if is_on_floor():
				finish_tutorial_level(1)
				vel.y -= jump_speed
			elif is_on_wall():
				finish_tutorial_level(2)
				if Input.is_action_pressed("move_right_button"):
					finish_tutorial_level(0)
					vel.y = 0
					vel.y -= jump_speed
					vel.x -= Globals.scroll_speed * 2
				if Input.is_action_pressed("move_left_button"):
					finish_tutorial_level(0)
					vel.y = 0
					vel.y -= jump_speed
					vel.x += Globals.scroll_speed * 2
	else: # wave movement
		vel = Vector2(0,0)
		if Input.is_action_pressed("jump_button"):
			finish_tutorial_level(1)
			switch_state()
			vel.y -= jump_speed
	vel = move_and_slide(vel, Vector2(0, -1))
