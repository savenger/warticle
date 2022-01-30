extends Control

func _on_Timer_count(new_value):
	$TopBar/Control_Score/Panel/Label_ScoreValue.text = str(int(new_value))

var current_level = -1

func _process(_delta):
	var new_level = Globals.tutorial_level
	if new_level != current_level:
		current_level = new_level
		
		var new_text = ""
		var is_active = true
		 
		match current_level:
			0:
				new_text = "You are a little photon. You are a wave, and you are a particle. A warticle!\nPress [b]A/D [/b] to move left/right."
			1: 
				new_text = "Press [b]Space[/b] to jump."
			2: 
				new_text = "You can also wall jump!"
			3: 
				new_text = "Press [b]K[/b] to switch to [wave amp=50 freq=16]wave[/wave] form to avoid holes.\nHoles = Death"
			4: 
				new_text = "Press [b]K[/b] to switch back \n You can't control the wave's direction"
			5: 
				new_text = "Keep up with the flow.\nLeft wall = also Death"
			6:
				new_text = "You go be a good little particle and get that highscore!"
				is_active = false
		
		
		update_text(new_text, is_active)

func update_text(text, is_active):
	$BottomBar/PanelContainer/RichTextLabel.bbcode_text = text
	if is_active:
		$BottomBar/PanelContainer.visible = true
	else:
		$BottomBar/AnimationPlayer.play("fadeout")
