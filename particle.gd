extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var speed = 1
var camera = null
var s_size = Vector2(1920, 1080)
var color = Vector3(0.0,0.0,0.0)

# Called when the node enters the scene tree for the first time.
func _ready():
	# Initialize with a random position and speed
	var x_pos = rand_range(0 , s_size.x)
	var y_pos = rand_range(0 , s_size.y)
	#var size = rand_range(0.1 , 1.0)
	speed = rand_range(1.0 , 3.0)
	position = Vector2( x_pos, y_pos )
	scale = Vector2(speed,speed)/3.0
	
	var r_col = rand_range(0.0 , 0.6)
	var g_col = rand_range(0.0 , 0.6)
	var b_col = rand_range(0.0 , 0.6)
	color = Vector3(r_col,g_col,b_col)
	get_node("Sprite").material.set_shader_param("color",color)
	
	# "camera" needs to be initialized

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	position.x -= speed
	
	var left_border = -100   #camera.position.x - s_size.x / 1.5
	var right_border = s_size.x+100  #camera.position.x + s_size.x / 1.5
	if position.x < left_border:
		position.x = right_border
	
