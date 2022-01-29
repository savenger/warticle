extends Line2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var amplitude = 20
var frequency = 0.1
var length = 100

# Called when the node enters the scene tree for the first time.
func _ready():
	var new_points = []
	for i in range(length):
		var x = i-length/2
		new_points.append(Vector2(x,sin(x*frequency)*amplitude))
	points = new_points
	
	gradient = Gradient.new()
	gradient.add_point(-1.0,Color(0,0,0))
	gradient.add_point(1.0,Color(1.0,1.0,1.0))
	
	pass # Replace with function body.

