extends KinematicBody2D

var player_state = 0 # 0: particle, 1: wave

const gravity = Globals.GRAVITY
const player_speed = Globals.SPEED
const player_speed_wave = player_speed * 3
const jump_speed = 2000
const acc = 5000

var vel = Vector2(0,0)

func get_input_x():
	var x_speed = Input.get_action_strength("move_right_button") - Input.get_action_strength("move_left_button")
	return x_speed

func switch_state():
	if player_state == 0:
		$Sprite.visible = false
		$Wave.visible = true
		player_state = 1
	else:
		$Sprite.visible = true
		$Wave.visible = false
		player_state = 0

func _process(delta):
	if Input.is_action_just_pressed("switch_button"):
		switch_state()

func _physics_process(delta):
	if player_state == 0: # particle movement
		var input_x = get_input_x()
		var target_speed = input_x * (player_speed - Globals.scroll_speed * input_x * 0.4)
		vel.x = move_toward(vel.x, target_speed, delta * acc)
		vel.x -= Globals.scroll_speed * 0.05
		vel.y += gravity * delta
		if Input.is_action_pressed("jump_button"):
			if is_on_floor():
				vel.y -= jump_speed
			elif is_on_wall():
				if Input.is_action_pressed("move_right_button"):
					vel.y = 0
					vel.y -= jump_speed
					vel.x -= player_speed * 2
				if Input.is_action_pressed("move_left_button"):
					vel.y = 0
					vel.y -= jump_speed
					vel.x += player_speed * 2
	else: # wave movement
		vel.y = 0
		vel.x = move_toward(vel.x, player_speed_wave, delta * acc)
		if Input.is_action_pressed("jump_button"):
			switch_state()
			vel.y -= jump_speed
	vel = move_and_slide(vel, Vector2(0, -1))
