extends Control



func _on_Timer_count(new_value):
	$TopBar/Control_Score/Panel/Label_ScoreValue.text = str(int(new_value))
