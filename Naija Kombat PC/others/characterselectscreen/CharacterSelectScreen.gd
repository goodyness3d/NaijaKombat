extends TextureRect


var charactersList = Characters.paths.keys()

onready var startButton = $HBoxContainer/Control2/MarginContainer/StartButton

var player2SelectScreen = "res://others/characterselectscreenp2/CharacterSelectScreen.tscn"
var storyModeEnemyScreen = "res://others/storymode/StoryModeEnemyScene.tscn"
var mainMenu = "res://others/mainmenu/MainMenu.tscn"

onready var itemList = $HBoxContainer/VBoxContainer/ItemList
onready var unlockLabel = $HBoxContainer/Control2/VBoxContainer/Label2
onready var previewer = $HBoxContainer/Control2/ViewportContainer/CharacterPreview
onready var logoLabel = $HBoxContainer/Control2/VBoxContainer

onready var labelIsUnlocked = SceneChanger.completedStoryMode

onready var unlockNotice = $HBoxContainer/Control2/UnlockNotice
onready var selectLabel = $HBoxContainer/VBoxContainer/Control/Label


func _ready():
	GameMusic.stream = load(GameSounds.storyMode)
	
	if GameSounds.musicIsEnabled:
		GameMusic.play()
	
	itemList.sort_items_by_text()
	itemList.grab_focus()
	
	if labelIsUnlocked:
		unlockLabel.hide()
	
	if Characters.numberOfPlayers == 2:
		selectLabel.text = "select fighter 1"


func _input(event):
	if event.is_action_pressed("ui_cancel"):
		_on_BackButton_pressed()


func _on_ItemList_item_activated(index):
	if Characters.unlocked[charactersList[index]] == true:
		Characters.selected[0] = charactersList[index]
		
		if SceneChanger.gameMode == "freefight":
			SceneChanger.goto_scene(self, player2SelectScreen)
		elif SceneChanger.gameMode == "story":
			SceneChanger.goto_scene(self, storyModeEnemyScreen)


func _notification(what):
	if what == MainLoop.NOTIFICATION_WM_GO_BACK_REQUEST:
		SceneChanger.goto_scene(self, mainMenu)


func _on_StartButton_pressed():
	pass


func _on_BackButton_pressed():
	SceneChanger.goto_scene(self, mainMenu)



func _on_ItemList_item_selected(index):
	logoLabel.hide()
	show_character_in_previewer(index)
	
	if Characters.unlocked[charactersList[index]] == true:
		unlockNotice.hide()
	else:
		unlockNotice.show()


func show_character_in_previewer(index):
		var shh = previewer.get_child_count()
		
		if shh > 2:
			previewer.get_child(2).queue_free()
		
		previewer.add_child(Characters.previewerPaths[charactersList[index]].instance())
