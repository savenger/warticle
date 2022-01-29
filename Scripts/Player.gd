extends KinematicBody2D

var player_state = 0 # 0: particle, 1: wave

var gravity = Globals.GRAVITY
var player_speed = Globals.SPEED
var player_speed_wave = player_speed * 3
var jump_speed = 2000
var acc = 5000

var vel = Vector2(0,0)

func get_input_x():
	var x_speed = Input.get_action_strength("move_right_button") - Input.get_action_strength("move_left_button")
	return x_speed

func switch_state():
	if player_state == 0:
		$Sprite.visible = false
		$Particles2D_Trail.emitting = true
		player_state = 1
	else:
		$Sprite.visible = true
		$Particles2D_Trail.emitting = false
		player_state = 0

func _process(delta):
	if Input.is_action_just_pressed("switch_button"):
		switch_state()

func _physics_process(delta):
	if player_state == 0: # particle movement
		var target_speed = get_input_x() * player_speed
		vel.x = move_toward(vel.x, target_speed, delta * acc)
		vel.y += gravity * delta
		if Input.is_action_pressed("jump_button"):
			if is_on_floor():
				vel.y -= jump_speed
			elif is_on_wall():
				if Input.is_action_pressed("move_right_button"):
					vel.y = 0
					vel.y -= jump_speed
					vel.x -= player_speed
				if Input.is_action_pressed("move_left_button"):
					vel.y = 0
					vel.y -= jump_speed
					vel.x += player_speed
	else: # wave movement
		vel.y = 0
		vel.x = move_toward(vel.x, player_speed_wave, delta * acc)
		if Input.is_action_pressed("jump_button"):
			switch_state()
			vel.y -= jump_speed
	vel = move_and_slide(vel, Vector2(0, -1))
