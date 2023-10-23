extends Control


var characterSelectScreen = "res://others/characterselectscreen/CharacterSelectScreen.tscn"


func open_character_select_screen():
	SceneChanger.goto_scene(self, characterSelectScreen)

func _input(event):
	if event.is_action_pressed("ui_accept"):
		open_character_select_screen()
