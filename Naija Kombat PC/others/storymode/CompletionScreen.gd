extends TextureRect


var mainMenu = "res://others/mainmenu/MainMenu.tscn"
var storyModeScreen = "res://others/storymode/StoryModeEnemyScene.tscn"


func _ready():
	
	GameMusic.stream = load(GameSounds.storyMode)
	
	if GameSounds.soundIsEnabled:
		GameMusic.play()
	
	if SceneChanger.completedStoryMode == true:
		$CompletionNotice.show()
		$UnlockNotice.hide()
	else:
		$UnlockNotice.text += Characters.selected[1]
	


func _input(event):
	if event.is_action_pressed("ui_accept"):
		if SceneChanger.completedStoryMode == true:
			SceneChanger.goto_scene(self, mainMenu)
		else:
			SceneChanger.goto_scene(self, storyModeScreen)
	
	if event.is_action_pressed("ui_cancel"):
		SceneChanger.goto_scene(self, mainMenu)
		
