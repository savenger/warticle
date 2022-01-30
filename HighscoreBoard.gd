extends ColorRect

var menu_scene = "res://Scenes/MainMenu.tscn"

func _on_Button_Back_pressed():
	get_tree().change_scene(menu_scene)

