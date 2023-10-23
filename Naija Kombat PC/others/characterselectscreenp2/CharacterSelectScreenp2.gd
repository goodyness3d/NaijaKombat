extends TextureRect


var charactersList = Characters.paths.keys()

onready var startButton = $HBoxContainer/Control2/MarginContainer/StartButton

onready var venueSelectScreen = "res://others/venueselectscreen/VenueSelectScreen.tscn"
onready var player1SelectScreen = "res://others/characterselectscreen/CharacterSelectScreen.tscn"

onready var previewer = $HBoxContainer/Control2/ViewportContainer/CharacterPreview
onready var itemList = $HBoxContainer/VBoxContainer/ItemList
onready var logoLabel = $HBoxContainer/Control2/Label
onready var unlockNotice = $HBoxContainer/Control2/UnlockNotice
onready var selectLabel = $HBoxContainer/VBoxContainer/Control/Label


func _ready():
	itemList.sort_items_by_text()
	itemList.grab_focus()
	
	if Characters.numberOfPlayers == 2:
		selectLabel.text = "select fighter 2"


func _input(event):
	if event.is_action_pressed("ui_cancel"):
		_on_BackButton_pressed()


func _on_ItemList_item_activated(index):
	if Characters.unlocked[charactersList[index]] == true:
		Characters.selected[1] = charactersList[index]
		
		SceneChanger.goto_scene(self, venueSelectScreen)


func _notification(what):
	if what == MainLoop.NOTIFICATION_WM_GO_BACK_REQUEST:
		SceneChanger.goto_scene(self, player1SelectScreen)


func _on_StartButton_pressed():
	pass


func _on_BackButton_pressed():
	SceneChanger.goto_scene(self, player1SelectScreen)


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
