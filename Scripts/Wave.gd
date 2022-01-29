extends Line2D

var amplitude = 30
var frequency = 0.05
var length = 400
var offset = 0

func congestion(x):
	return -sin(float(x)/length*2 * 20)

# Called when the node enters the scene tree for the first time.
func _ready():
	var new_points = []
	for i in range(length):
		var x = i-length
		var y = congestion(x)*sin(x*frequency)*amplitude
		new_points.append(Vector2(x,y))
	points = new_points

func _process(delta):
	for i in range(length):
		var x = i-length
		var y = congestion(x)*sin(x*frequency+offset)*amplitude
		points[i] = Vector2(x,y)

	offset += (get_parent().wave_speed + get_parent().vel.x)/60 *frequency

	
	
	
	

