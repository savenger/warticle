extends Control




func _ready():
	pass # TODO set score


func set_score(score):
	$VBoxContainer/CenterContainer2/VBoxContainer/LineEdit.text = score


func _on_Button_pressed():
	pass # TODO Initalise restart here
