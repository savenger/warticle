extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var current_level: String


# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func die():
	get_tree().reload_current_scene()

func _on_Pit_body_entered(body):
	if body.name == "Player":
		die()


func _on_Left_body_entered(body):
	if body.name == "Player":
		die()


func _on_Right_body_entered(body):
	if body.name == "Player":
		die()
