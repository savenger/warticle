extends Node2D

var count = 0
signal count(new_value)

func _process(delta):
	if Globals.in_tutorial_level:
		return
	count += delta
	emit_signal("count", count)
