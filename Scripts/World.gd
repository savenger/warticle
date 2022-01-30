extends Node2D

var current_level: String
var current_slices: Array

func die():
	Globals.highscores.append( "Test "+ str(Globals.score))
	Globals.highscores.sort()
	Globals.highscores.invert()
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

func _input(ev):
	if ev is InputEventKey and ev.scancode == KEY_M:
		get_tree().change_scene("res://Scenes/MainMenu.tscn")
		
		
