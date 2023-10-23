extends Label


onready var screen = self.get_parent()

onready var gameMode = SceneChanger.gameMode
onready var playerWins = Characters.isWinner
onready var storyModeProgress = SceneChanger.storyModeProgress
onready var grudgeFightProgress = SceneChanger.grudgeFightProgress

var storyModeScreen = "res://others/storymode/StoryModeEnemyScene.tscn"
var characterSelectScreen = "res://others/characterselectscreen/CharacterSelectScreen.tscn"
var completionScreen = "res://others/storymode/CompletionScreen.tscn"
var grudgeFightScreen = "res://others/grudgefights/GrudgeFightSelect.tscn"


func change():
	if gameMode == "story" and playerWins:
		if storyModeProgress <= 14:
			SceneChanger.goto_scene(screen.get_parent(), completionScreen)
		else:
			Characters.unlocked["PMB"] = true
			Venues.unlocked["PresidosVilla"] = true
			
			SceneChanger.set("completedStoryMode", true)
			SceneChanger.set("storyModeProgress", 0)
			SceneChanger.goto_scene(screen.get_parent(), completionScreen)
	
	elif gameMode == "story" and !playerWins:
		SceneChanger.goto_scene(screen.get_parent(), characterSelectScreen)
	
	elif gameMode == "freefight":
		SceneChanger.goto_scene(screen.get_parent(), characterSelectScreen)
