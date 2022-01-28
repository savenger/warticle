extends KinematicBody2D

var gravity = Globals.GRAVITY
var player_speed = Globals.PLAYER_SPEED
var jump_speed = 800
var acc = 1700

var vel = Vector2(0,0)

func get_input_x():
	var x_speed = Input.get_action_strength("move_right_button") - Input.get_action_strength("move_left_button")
	return x_speed

func _physics_process(delta):
	var target_speed = get_input_x() * player_speed
	vel.x = move_toward(vel.x, target_speed, delta * acc)
	vel.y += gravity * delta
	vel = move_and_slide(vel, Vector2(0, -1))

