extends KinematicBody2D

var player_state = 0 # 0: particle, 1: wave

const gravity = Globals.GRAVITY
const speed = 900
const wave_speed = speed * 2
const jump_speed = 2000
const acc = 8000

var vel = Vector2(0,0)
var scroll_speedup = false
var can_jump = true

func _ready():
	pass

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
	$SFX/ASP_Switch.play()
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
	#finish_tutorial_level(5)
	if Input.is_action_pressed("volume_up"):
		Globals.audio_volume += 10 * delta
		Globals.set_master_volume(Globals.audio_volume)
	if Input.is_action_pressed("volume_down"):
		Globals.audio_volume -= 10 * delta
		Globals.set_master_volume(Globals.audio_volume)
	if Input.is_action_just_pressed("switch_button"):
		switch_state()
	scroll_speedup = self.global_position.x > Globals.LEVEL_WIDTH * 0.96 and Input.is_action_pressed("move_right_button")

func _physics_process(delta):
	if player_state == 0: # particle movement
		var input_x = get_input_x()
		if input_x != 0:
			finish_tutorial_level(0)
		if is_on_floor() and not can_jump:
			can_jump = true
		var target_speed = -Globals.scroll_speed + input_x * speed * int(!scroll_speedup)
		vel.x = move_toward(vel.x, target_speed, delta * acc)
		vel.y += gravity * delta
		if Input.is_action_just_pressed("jump_button"):
			if is_on_floor():
				finish_tutorial_level(1)
				vel.y -= jump_speed
				$SFX/ASP_Jump.play()
			elif is_on_wall():
				finish_tutorial_level(2)
				if Input.is_action_pressed("move_right_button"):
					finish_tutorial_level(0)
					vel.y = 0
					vel.y -= jump_speed
					vel.x -= Globals.scroll_speed * 2
					$SFX/ASP_Jump.play()
				if Input.is_action_pressed("move_left_button"):
					finish_tutorial_level(0)
					vel.y = 0
					vel.y -= jump_speed
					vel.x += Globals.scroll_speed * 2
	else: # wave movement
		vel.y = 0
		var target_speed = -Globals.scroll_speed + speed / 2 * int(!scroll_speedup)
		vel.x = move_toward(vel.x, target_speed, delta * acc)
		if Input.is_action_just_pressed("jump_button"):
			finish_tutorial_level(1)
			switch_state()
			if can_jump:
				vel.y -= jump_speed
				can_jump = false
		if is_on_wall():
			switch_state()
	vel = move_and_slide(vel, Vector2(0, -1))
	if is_on_wall() and player_state == 1:
		switch_state()
