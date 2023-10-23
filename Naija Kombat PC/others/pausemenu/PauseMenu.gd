extends CanvasLayer



onready var fightingVenue = get_parent()

var mainMenu = "res://others/mainmenu/MainMenu.tscn"

var hasPressedOptions = false


func _ready():
	get_tree().paused = true
	
	$Overlay/VBoxContainer/ResumeButton.grab_focus()


func _input(event):
	if Input.is_action_just_pressed("ui_cancel") and !hasPressedOptions:
		_on_ResumeButton_pressed()


func resume():
	queue_free()
	get_tree().set("paused", false)


func _on_ResumeButton_pressed():
	$Overlay/AnimationPlayer.play("exit")


func _on_OptionsButton_pressed():
	hasPressedOptions = true
	SceneChanger.show_options_menu(self, "pause")


func _on_MainMenuButton_pressed():
	get_tree().set("paused", false)
	queue_free()
	SceneChanger.goto_scene(fightingVenue, mainMenu)
