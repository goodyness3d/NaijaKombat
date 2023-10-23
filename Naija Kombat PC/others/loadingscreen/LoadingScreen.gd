extends CanvasLayer



func _ready():
	$Label.text = SceneChanger.loadingScreenText
	
	if SceneChanger.gameMode == "story":
		SceneChanger.save_game()
