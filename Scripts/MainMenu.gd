extends ColorRect

var game_scene = "res://Scenes/World.tscn"

"""
func _ready():
	$Control/Settings/VBoxContainer/HBoxContainer/VBoxContainer/CenterContainer/Slider_MusicVolume.set("value", Globals.audio_volume + 100)
	$Control/Settings/VBoxContainer/HBoxContainer/VBoxContainer/CenterContainer2/Slider_SFXVolume.set("value", Globals.sfx_volume + 100)
"""

func _on_Button_Quit_pressed():
	get_tree().notification(MainLoop.NOTIFICATION_WM_QUIT_REQUEST)

func _on_Button_Highscores_pressed():
	get_tree().change_scene("res://Scenes/HighscoreBoard.tscn")

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


func _on_Slider_MusicVolume_value_changed(value):
	Globals.set_music_volume(value - 100)


func _on_Slider_SFXVolume_value_changed(value):
	Globals.set_sfx_volume(value - 100)
