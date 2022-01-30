extends Node2D

var current_level: String
var current_slices: Array

"""
func _ready():
	var arr = ["",11,1,"",4]
	arr.sort_custom(self, "customComparison")
	print (arr)

func customComparison(a, b):
	if typeof(a) != typeof(b):
		return typeof(a) < typeof(b)
	else:
		return a < b
"""

func die():
	Globals.highscores.append(Globals.score)
	Globals.highscores.sort()
	Globals.highscores.invert()
	
	get_tree().reload_current_scene()
	Globals.scroll_speed = 250
	Globals.score = 0

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
		
		
