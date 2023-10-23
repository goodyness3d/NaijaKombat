extends TextureRect



var characterSelectScreen = "res://others/characterselectscreen/CharacterSelectScreen.tscn"
var storyModeScreen = "res://others/storymode/StoryModeScene.tscn"
var grudgeFightScreen = "res://others/grudgefights/GrudgeFightSelect.tscn"

var hasPressedOptions = false

onready var backButton = $HBoxContainer/Control/MarginContainer/BackButton

onready var viewport = SceneChanger.parentViewport


func _ready():
	if Characters.hasLoadedPreviewer == false:
		Characters.load_previewer_paths()
	
	SceneChanger.loadingScreenText = ""
	
	GameMusic.stream = load(GameSounds.mainMenu)
	
	if GameSounds.musicIsEnabled:
		GameMusic.play()
	
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	
	$HBoxContainer/VBoxContainer/StoryModeButton.grab_focus()
	
	setup_graphics()


func setup_graphics():
	if SceneChanger.graphicsMode == "low":
		viewport.shadow_atlas_size = 0
		viewport.fxaa = true
		
	if SceneChanger.graphicsMode == "high":
		viewport.shadow_atlas_size = 4096
		viewport.fxaa = false


func _input(event):
	if Input.is_action_just_pressed("ui_cancel") and !hasPressedOptions:
		backButton.grab_focus()


func _on_StoryModeButton_pressed():
	SceneChanger.gameMode = "story"
	if SceneChanger.storyModeProgress > 0:
		SceneChanger.goto_scene(self, characterSelectScreen)
	else:
		SceneChanger.goto_scene(self, storyModeScreen)


func _on_FreeFightButton_pressed():
	SceneChanger.gameMode = "freefight"
	SceneChanger.goto_scene(self, characterSelectScreen)
	
	Characters.set("numberOfPlayers", 1)


func _on_GrudgeFightsButton2_pressed():
	SceneChanger.gameMode = "grudgefight"
	SceneChanger.goto_scene(self, grudgeFightScreen)


func _on_OptionsButton_pressed():
	SceneChanger.show_options_menu(self, "main")
	
	hasPressedOptions = true


func _on_BackButton_pressed():
	get_tree().quit()


func _on_2PlayersButton_pressed():
	SceneChanger.gameMode = "freefight"
	SceneChanger.goto_scene(self, characterSelectScreen)
	
	Characters.set("numberOfPlayers", 2)
