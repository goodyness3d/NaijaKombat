extends CanvasLayer



onready var musicButton = $Overlay/HBoxContainer/Control2/Label/VBoxContainer/MusicButton
onready var soundButton = $Overlay/HBoxContainer/Control2/Label/VBoxContainer/SFXButton
onready var helpButton = $Overlay/HBoxContainer/Control2/Label/VBoxContainer/HelpButton
onready var helpMenu = $HelpMenu
onready var licenseMenu = $LicenseScreen

onready var lowQuality = $Overlay/HBoxContainer/Control/Background/VBoxContainer/LowQuality
onready var highQuality = $Overlay/HBoxContainer/Control/Background/VBoxContainer/HighQuality


onready var theScene = get_parent()

onready var viewport = SceneChanger.parentViewport


func _ready():
	if GameSounds.soundIsEnabled:
		soundButton.set("pressed", true)
	if GameSounds.musicIsEnabled:
		musicButton.set("pressed", true)
	
	soundButton.grab_focus()
	
	setup_graphics()


func setup_graphics():
	if SceneChanger.graphicsMode == "low":
		lowQuality.pressed = true
		highQuality.pressed = false
		
	if SceneChanger.graphicsMode == "high":
		lowQuality.pressed = false
		highQuality.pressed = true


func _input(event):
	if Input.is_action_just_pressed("ui_cancel"):
		if helpMenu.visible:
			helpMenu.hide()
			helpButton.grab_focus()
		
		else:
			yield(get_tree().create_timer(0.2), "timeout")
			_on_DoneButton_pressed()


func _on_SFXButton_pressed():
	if GameSounds.soundIsEnabled:
		GameSounds.set("soundIsEnabled", false)
	else:
		GameSounds.set("soundIsEnabled", true)


func _on_DoneButton_pressed():
	$AnimationPlayer.play("exit")
	get_parent().get_node("Overlay/VBoxContainer/OptionsButton").grab_focus()
	get_parent().set("hasPressedOptions", false)


func _on_HelpButton_pressed():
	$HelpMenu.show()
	$HelpMenu/MarginContainer/BackButton.grab_focus()


func _on_BackButton_pressed():
	$HelpMenu.hide()
	helpButton.grab_focus()


func _on_MusicButton_pressed():
	if GameSounds.musicIsEnabled:
		GameSounds.set("musicIsEnabled", false)
		GameMusic.stop()
	else:
		GameSounds.set("musicIsEnabled", true)
		GameMusic.play()


func _on_LowQuality_pressed():
	SceneChanger.graphicsMode = "low"
	highQuality.pressed = false
	
	viewport.shadow_atlas_size = 0
	viewport.fxaa = true


func _on_HighQuality_pressed():
	SceneChanger.graphicsMode = "high"
	lowQuality.pressed = false
	
	viewport.shadow_atlas_size = 4096
	viewport.fxaa = false
