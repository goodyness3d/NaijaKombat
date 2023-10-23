extends Spatial



var player1
var player2

var rightbodyCount = 0
var leftbodyCount = 0

onready var camMover = $Camera/Tween
onready var camPosition = $Camera.global_transform.origin
onready var camFov = $Camera.fov

var canPause = false
onready var pauseMenu = load("res://others/pausemenu/PauseMenu.tscn")

func _ready():
	GameMusic.stream = load(GameSounds.grudgeFight)
	if GameSounds.soundIsEnabled:
		GameMusic.play()
	
	var playerPath = Characters.paths
	var playerSelected = Characters.selected
	
	player1 = load(playerPath[playerSelected[0]]).instance()
	player2 = load(playerPath[playerSelected[1]]).instance()
	
	player1.isPlayer = true
	player2.isEnemy = true
	
	set("pause_mode", PAUSE_MODE_STOP)
	
	SceneChanger.loadingScreenText = ""
	
	add_child(player1)
	player1.global_transform.origin = $SpawnLocations/Player.global_transform.origin
	add_child(player2)
	player2.global_transform.origin = $SpawnLocations/Enemy.global_transform.origin
		
	
	Characters.show_touch_controls(self)
	set("canPause", true)


func _input(event):
	if event.is_action_pressed("pause"):
		if canPause:
			pause_game()


func pause_game():
	add_child(pauseMenu.instance())


func _notification(what):
	if what == MainLoop.NOTIFICATION_WM_GO_BACK_REQUEST:
		if canPause:
			pause_game()


func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "entry":
		add_child(player1)
		player1.global_transform.origin = $SpawnLocations/Player.global_transform.origin
		add_child(player2)
		player2.global_transform.origin = $SpawnLocations/Enemy.global_transform.origin
		$AnimationPlayer.play("p1")
		
	elif anim_name == "p1":
		$AnimationPlayer.play("p2")
		
	elif anim_name == "p2":
		$Camera.current = true
		
		if $AnimationPlayer.has_animation("ingame"):
			$AnimationPlayer.play("ingame")
		
		if has_node("Structures/Delete"):
			get_node("Structures/Delete").queue_free()
	
		Characters.show_touch_controls(self)
		set("canPause", true)
		
		Sfx.stream = load(GameSounds.fightStart)
		Sfx.play()


func fight_ended():
	camMover.interpolate_property($Camera, "fov", null, 45, 0.4, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT, 0)
	camMover.start()
	set("canPause", false)
	
	GameMusic.stop()
	GameMusic.stream = load(GameSounds.fightEnd)
	
	yield(get_tree().create_timer(1),"timeout")
	
	GameMusic.play()
		


func _on_LeftSide_body_entered(body):
	if body is KinematicBody:
		if leftbodyCount == 1:
			camMover.interpolate_property($Camera, "translation", null, camPosition + Vector3(-2,0,0), 0.4, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT, 0)
			camMover.interpolate_property($Camera, "fov", null, 50, 0.4, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT, 0)
			camMover.start()
		leftbodyCount += 1


func _on_LeftSide_body_exited(body):
	if body is KinematicBody:
		if leftbodyCount == 2:
			camMover.interpolate_property($Camera, "translation", null, camPosition, 0.4, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT, 0)
			camMover.interpolate_property($Camera, "fov", null, camFov, 0.4, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT, 0)
			camMover.start()
		leftbodyCount -= 1


func _on_RightSide_body_entered(body):
	if body is KinematicBody:
		if rightbodyCount == 1:
			camMover.interpolate_property($Camera, "translation", null, camPosition + Vector3(2,0,0), 0.4, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT, 0)
			camMover.interpolate_property($Camera, "fov", null, 50, 0.4, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT, 0)
			camMover.start()
		rightbodyCount += 1


func _on_RightSide_body_exited(body):
	if body is KinematicBody:
		if rightbodyCount == 2:
			camMover.interpolate_property($Camera, "translation", null, camPosition, 0.4, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT, 0)
			camMover.interpolate_property($Camera, "fov", null, camFov, 0.4, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT, 0)
			camMover.start()
		rightbodyCount -= 1
