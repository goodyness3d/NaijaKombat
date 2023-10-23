extends ColorRect


var logoScene = "res://others/logoscene/LogoScene.tscn"


func _ready():
	SceneChanger.parentViewport = get_parent()


func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "entry":
		SceneChanger.goto_scene(self, logoScene)
