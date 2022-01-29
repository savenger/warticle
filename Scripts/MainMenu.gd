extends ColorRect

var game_scene = "res://Scenes/World.tscn"

func _on_Button_Quit_pressed():
	get_tree().notification(MainLoop.NOTIFICATION_WM_QUIT_REQUEST)


func _on_Button_ControlsBack_pressed():
	$Control/Controls.visible = false


func _on_Button_SettingsBack_pressed():
	$Control/Settings.visible = false


func _on_Button_Start_pressed():
	get_tree().change_scene(game_scene)


func _on_Button_Controls_pressed():
	$Control/Controls.visible = true


func _on_Button_Settings_pressed():
	$Control/Settings.visible = true


func _on_Button_Credits_pressed():
	$Control/Credits.visible = true


func _on_Button_CreditsBack_pressed():
	$Control/Credits.visible = false
