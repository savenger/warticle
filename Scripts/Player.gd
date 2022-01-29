extends KinematicBody2D

var player_state = 0 # 0: particle, 1: wave
var particle_sprite = load("res://Assets/white_circle_100x.png")
var wave_sprite = load("res://Assets/placeholder_player_wave.png")

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

func switch_state():
	if player_state == 0:
		$Sprite.texture = wave_sprite
		player_state = 1
	else:
		$Sprite.texture = particle_sprite
		player_state = 0

func _process(delta):
	if Input.is_action_just_pressed("switch_button"):
		switch_state()
	scroll_speedup = self.global_position.x > Globals.LEVEL_WIDTH * 0.9 and Input.is_action_pressed("move_right_button")

func _physics_process(delta):
	if player_state == 0: # particle movement
		var input_x = get_input_x()
		var target_speed = input_x * speed * int(!scroll_speedup)
		vel.x = move_toward(vel.x, target_speed, delta * acc)
		vel.y += gravity * delta
		if Input.is_action_pressed("jump_button"):
			if is_on_floor():
				vel.y -= jump_speed
			elif is_on_wall():
				if Input.is_action_pressed("move_right_button"):
					vel.y = 0
					vel.y -= jump_speed
					vel.x -= Globals.scroll_speed * 2
				if Input.is_action_pressed("move_left_button"):
					vel.y = 0
					vel.y -= jump_speed
					vel.x += Globals.scroll_speed * 2
	else: # wave movement
		vel = Vector2(0,0)
		if Input.is_action_pressed("jump_button"):
			switch_state()
			vel.y -= jump_speed
	vel = move_and_slide(vel, Vector2(0, -1))
