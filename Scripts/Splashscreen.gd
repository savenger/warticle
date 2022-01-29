extends Control

var game_scene = "res://Scenes/MainMenu.tscn"

func _on_Timer_timeout():
	start_game()

func _input(event):
	if event is InputEventKey and event.pressed:
		start_game() 

func start_game():
	get_tree().change_scene(game_scene)
