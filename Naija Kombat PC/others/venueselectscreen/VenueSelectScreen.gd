extends TextureRect


var venuesList = Venues.paths.keys()
onready var startButton = $HBoxContainer/Control2/MarginContainer/StartButton
onready var player2SelectScreen = "res://others/characterselectscreenp2/CharacterSelectScreen.tscn"
onready var itemList = $HBoxContainer/VBoxContainer/ItemList
onready var unlockNotice = $UnlockNotice


func _ready():
	itemList.sort_items_by_text()
	itemList.grab_focus()


func _input(event):
	if event.is_action_pressed("ui_cancel"):
		_on_BackButton_pressed()


func _on_ItemList_item_activated(index):
	if Venues.unlocked[venuesList[index]] == true:
		Venues.selected = [venuesList[index]]
	
		var sceneSelected = Venues.selected[0]
		var scenePath = Venues.paths[sceneSelected]
	
		SceneChanger.loadingScreenText = sceneSelected
		SceneChanger.goto_scene(self, scenePath)


func _notification(what):
	if what == MainLoop.NOTIFICATION_WM_GO_BACK_REQUEST:
		SceneChanger.goto_scene(self, player2SelectScreen)


func _on_StartButton_pressed():
	pass


func _on_BackButton_pressed():
	SceneChanger.goto_scene(self, player2SelectScreen)


func _on_ItemList_item_selected(index):
	var itsName = venuesList[index]
	
	Venues.selected[0] = itsName
	
	self.texture = load("res://venuefullpics/" + itsName + ".png")
	
	if Venues.unlocked[itsName] == true:
		unlockNotice.hide()
	else:
		unlockNotice.show()
