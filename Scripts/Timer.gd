extends Node2D

var count = 0
signal count(new_value)

func _process(delta):
	if Globals.in_tutorial_level:
		return
	count += 1.0/60.0
	emit_signal("count", count)
