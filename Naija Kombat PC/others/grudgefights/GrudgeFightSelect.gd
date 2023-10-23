extends TextureRect



var mainMenu = "res://others/mainmenu/MainMenu.tscn"
var nextScreen = "res://others/grudgefights/GrudgeFights.tscn"

onready var startButton = $HBoxContainer/Control2/MarginContainer/StartButton


func _ready():
	GameMusic.stream = load(GameSounds.grudgeFight)
	
	if GameSounds.soundIsEnabled:
		GameMusic.play()


func _input(event):
	if event.is_action_pressed("ui_cancel"):
		_on_BackButton_pressed()


func _on_ItemList_item_selected(index):
	SceneChanger.grudgeFightProgress = index
	startButton.show()


func _on_StartButton_pressed():
	SceneChanger.goto_scene(self, nextScreen)
	$HBoxContainer/Control2/MarginContainer/StartButton.show()


func _on_BackButton_pressed():
	SceneChanger.goto_scene(self, mainMenu)
