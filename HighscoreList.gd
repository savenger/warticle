extends VBoxContainer


func _ready():
	for x in Globals.highscores:
		var new_label = Label.new()	
		new_label.text = str(x)
		add_child(new_label)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
