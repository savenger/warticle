extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var speed = 1
var camera = null
var s_size = Vector2(1920, 1080)
var color = Vector3(0.0,0.0,0.0)

var player

# Called when the node enters the scene tree for the first time.
func _ready():
	player = get_parent().get_parent().get_node("rainbow_animation/Player")
	# Initialize with a random position and speed
	var x_pos = rand_range(0 , s_size.x)
	var y_pos = rand_range(0 , s_size.y)
	#var size = rand_range(0.1 , 1.0)
	speed = rand_range(1.0 , 3.0)
	position = Vector2( x_pos, y_pos )
	scale = Vector2(speed,speed)/3
	"""
	var r_col = pow(rand_range(0.0 , 1),2)*0.1
	var g_col = pow(rand_range(0.0 , 1),2)*0.3
	var b_col = pow(rand_range(0.0 , 1),2)*0.3
	"""
	
	var cols = [Color(1,0,0),Color(0,1,0),Color(0,0,1),Color(1,1,0),Color(0,1,1),Color(1,0,1)]
	var i = int(rand_range(0,6))
	
	color = Vector3(cols[i].r,cols[i].g,cols[i].b)*0.2
	$Sprite.material.set_shader_param("color",color)
	
	# "camera" needs to be initialized

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	if player.player_state == 0: # wave
		position.x -= speed * Globals.scroll_speed * delta * 0.5
		scale.x = speed*1/3
		scale.y = speed/3
	else: # particle
		position.x -= speed * Globals.scroll_speed * 8 * delta * 0.5
		scale.x = speed*2
		scale.y = speed/3/2
	
	var left_border = -100   #camera.position.x - s_size.x / 1.5
	var right_border = s_size.x+100  #camera.position.x + s_size.x / 1.5
	if position.x < left_border:
		position.x = right_border
	
