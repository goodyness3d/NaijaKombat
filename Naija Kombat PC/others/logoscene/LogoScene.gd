extends Control



var disclaimerScreen = "res://others/Disclaimer/DisclaimerScreen.tscn"


func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "Logo":
		SceneChanger.goto_scene(self, disclaimerScreen)
