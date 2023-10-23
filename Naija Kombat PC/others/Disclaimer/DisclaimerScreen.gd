extends ColorRect



var splashScreen = "res://others/mainmenu/MainMenu.tscn"


func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "entry":
		SceneChanger.load_game()
		SceneChanger.goto_scene(self, splashScreen)

func _input(event):
	if event.is_action_pressed("ui_accept"):
		_on_AnimationPlayer_animation_finished("entry")
