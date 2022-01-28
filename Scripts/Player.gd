extends KinematicBody2D

var gravity = Globals.GRAVITY
var player_speed = Globals.PLAYER_SPEED
var jump_speed = 1500
var acc = 5000

var vel = Vector2(0,0)

func get_input_x():
	var x_speed = Input.get_action_strength("move_right_button") - Input.get_action_strength("move_left_button")
	return x_speed

func _physics_process(delta):
	var target_speed = get_input_x() * player_speed
	vel.x = move_toward(vel.x, target_speed, delta * acc)
	vel.y += gravity * delta
	if is_on_floor() or is_on_wall():
		if Input.is_action_pressed("jump_button"):
			vel.y -= jump_speed
	if Input.is_action_pressed("down_button"):
		vel.y += player_speed
	vel = move_and_slide(vel)

