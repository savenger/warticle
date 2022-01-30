extends Node2D

var current_level: String
var current_slices: Array

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
