extends Control

var current_level = -1
var is_active = false


func _process(_delta):
	$TopBar/Control_Score/Panel/Label_ScoreValue.text = str(int(Globals.score))
	var new_level = Globals.tutorial_level
	if new_level != current_level:
		
		current_level = new_level
		
		print(current_level)
		
		var new_text = ""
		
		
		 
		match current_level:
			0:
				is_active = true
				$BottomBar/PanelContainer.visible = true
				new_text = "You are a little photon. You are a [wave amp=50 freq=16]wave[/wave] , and you are a [shake rate=5 level=10]particle[/shake]. [shake rate=5 level=10][rainbow freq=0.2 sat=10 val=20][wave amp=50 freq=16]A warticle![/wave][/rainbow][/shake] \nPress [b]A/D [/b] to move left/right. Do mind the left wall, it means death!"
			1: 
				is_active = true
				$BottomBar/PanelContainer.visible = true
				new_text = "Press [b]Space[/b] to jump."
			2: 
				is_active = true
				$BottomBar/PanelContainer.visible = true
				new_text = "You can also wall jump!"
			3: 
				is_active = true
				$BottomBar/PanelContainer.visible = true
				new_text = "Press [b]K[/b] to switch to [wave amp=50 freq=16]wave[/wave] form to avoid holes.\nHoles = Death"
			4: 
				is_active = true
				$BottomBar/PanelContainer.visible = true
				new_text = "Press [b]K[/b] to switch back \n You can't control the wave's direction"
			5: 
				
				new_text = "You go be a good little particle and get that highscore!"
				is_active = false
		
		update_text(new_text, is_active)

func update_text(text, is_active):
	$BottomBar/PanelContainer/RichTextLabel.bbcode_text = text
	if is_active:
		$BottomBar/PanelContainer.visible = true
	else:
		$BottomBar/AnimationPlayer.play("fadeout")
