extends KinematicBody2D

var gravity = Globals.GRAVITY
var player_speed = Globals.SPEED
var jump_speed = 2000
var acc = 5000

var vel = Vector2(0,0)

func get_input_x():
	var x_speed = Input.get_action_strength("move_right_button") - Input.get_action_strength("move_left_button")
	return x_speed

func _physics_process(delta):
	var target_speed = get_input_x() * player_speed
	vel.x = move_toward(vel.x, target_speed, delta * acc)
	vel.y += gravity * delta
	if Input.is_action_pressed("jump_button"):
		if is_on_floor():
			vel.y -= jump_speed
		elif is_on_wall():
			vel.y = 0
			if Input.is_action_pressed("move_right_button"):
				vel.y -= jump_speed
				vel.x -= player_speed * 2
			if Input.is_action_pressed("move_left_button"):
				vel.y -= jump_speed
				vel.x += player_speed * 2
	vel = move_and_slide(vel, Vector2(0, -1))
