extends CanvasLayer



onready var soundButton = $Overlay/HBoxContainer/Control2/Label/VBoxContainer/SoundButton
onready var licenseButton = $Overlay/HBoxContainer/Control2/Label/VBoxContainer/LicensesButton
onready var helpButton = $Overlay/HBoxContainer/Control2/Label/VBoxContainer/HelpButton
onready var helpMenu = $HelpMenu
onready var licenseMenu = $LicenseScreen

onready var hardDiff = $Overlay/HBoxContainer/Control3/Background/VBoxContainer/HardDifficulty
onready var normalDiff = $Overlay/HBoxContainer/Control3/Background/VBoxContainer/NormalDifficulty

onready var lowQuality = $Overlay/HBoxContainer/Control/Background/VBoxContainer/LowQuality
onready var highQuality = $Overlay/HBoxContainer/Control/Background/VBoxContainer/HighQuality

onready var mainMenu = get_parent()

onready var viewport = SceneChanger.parentViewport


func _ready():
	if GameSounds.soundIsEnabled:
		soundButton.set("pressed", true)
	
	soundButton.grab_focus()
	
	setup_difficulty()
	setup_graphics()


func setup_difficulty():
	if SceneChanger.difficulty == "normal":
		normalDiff.pressed = true
		hardDiff.pressed = false
		
	if SceneChanger.difficulty == "hard":
		normalDiff.pressed = false
		hardDiff.pressed = true


func setup_graphics():
	if SceneChanger.graphicsMode == "low":
		lowQuality.pressed = true
		highQuality.pressed = false
		
	if SceneChanger.graphicsMode == "high":
		lowQuality.pressed = false
		highQuality.pressed = true


func _process(delta):
	if licenseMenu.visible:
		if Input.is_action_pressed("ui_down"):
			$LicenseScreen/ScrollContainer.scroll_vertical += 10
		if Input.is_action_pressed("ui_up"):
			$LicenseScreen/ScrollContainer.scroll_vertical -= 10


func _input(event):
	if Input.is_action_just_pressed("ui_cancel"):
		if helpMenu.visible:
			helpMenu.hide()
			helpButton.grab_focus()
		
		elif licenseMenu.visible:
			licenseMenu.hide()
			licenseButton.grab_focus()
		
		else:
			yield(get_tree().create_timer(0.2), "timeout")
			_on_DoneButton_pressed()


func _on_SoundButton_pressed():
	if GameSounds.musicIsEnabled:
		GameSounds.set("musicIsEnabled", false)
		GameMusic.stop()
	else:
		GameSounds.set("musicIsEnabled", true)
		GameMusic.play()


func _on_DoneButton_pressed():
	SceneChanger.save_game()
	
	$AnimationPlayer.play("exit")
	
	mainMenu.get_node("HBoxContainer/VBoxContainer/OptionsButton").grab_focus()
	mainMenu.set("hasPressedOptions", false)
	


func _on_LicensesButton_pressed():
	$LicenseScreen.show()

	$LicenseScreen/MarginContainer/BackButton.connect("pressed", self, "hide_license_screen")
	$LicenseScreen/MarginContainer/BackButton.grab_focus()


func hide_license_screen():
	$LicenseScreen.hide()
	licenseButton.grab_focus()


func _on_HelpButton_pressed():
	$HelpMenu.show()
	$HelpMenu/MarginContainer/BackButton.grab_focus()


func _on_BackButton_pressed():
	$HelpMenu.hide()
	helpButton.grab_focus()


func _on_NormalDifficulty_pressed():
	SceneChanger.difficulty = "normal"
	hardDiff.pressed = false


func _on_HardDifficulty_pressed():
	SceneChanger.difficulty = "hard"
	normalDiff.pressed = false


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
