extends Node2D

const Particle = preload("res://particle.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	for x in range(400):
		var new_particle = Particle.instance()
		self.add_child(new_particle)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
