extends Spatial



var player1
var player2

var initialDistBtwThem

onready var camera = $Camera
onready var camMover = $Camera/Tween
onready var camFov = $Camera.fov
onready var camTrans = $Camera.translation.z

var canPause = false
var pauseMenu = load("res://others/pausemenu/PauseMenu.tscn")

var beginCameraTracking = false

func _ready():
	GameMusic.stream = load(GameSounds.grudgeFight)
	if GameSounds.musicIsEnabled:
		GameMusic.play()
	
	var playerPath = Characters.paths
	var playerSelected = Characters.selected
	
	player1 = load(playerPath[playerSelected[0]]).instance()
	player2 = load(playerPath[playerSelected[1]]).instance()
	
	player1.isPlayer = true
	
	if Characters.numberOfPlayers == 1:
		player2.isEnemy = true
	if Characters.numberOfPlayers == 2:
		player2.isPlayer2 = true
	
	set("pause_mode", PAUSE_MODE_STOP)
	
	SceneChanger.loadingScreenText = ""


func _input(event):
	if event.is_action_pressed("pause"):
		if canPause:
			pause_game()
	
	if $AnimationPlayer.current_animation == "entry":
		if  event.is_action_pressed("pause"):
			_on_AnimationPlayer_animation_finished("entry")


func pause_game():
	add_child(pauseMenu.instance())


func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "entry":
		call_deferred("add_child", player1)
		player1.global_transform.origin = $SpawnLocations/Player.global_transform.origin
		call_deferred("add_child", player2)
		player2.global_transform.origin = $SpawnLocations/Enemy.global_transform.origin
		$AnimationPlayer.play("p1")
		
	elif anim_name == "p1":
		$AnimationPlayer.play("p2")
		
	elif anim_name == "p2":
		camera.current = true
		set("beginCameraTracking", true)
		
		initialDistBtwThem = player2.translation.x - player1.translation.x
		
		if $AnimationPlayer.has_animation("ingame"):
			$AnimationPlayer.play("ingame")
		
		if has_node("Structures/Delete"):
			get_node("Structures/Delete").queue_free()
	
		Characters.show_touch_controls(self)
		set("canPause", true)
		
		Sfx.stream = load(GameSounds.fightStart)
		Sfx.play()
		
		player1.set_things()
		player2.set_things()


func fight_ended():
	camMover.interpolate_property($Camera, "fov", null, 45, 0.4, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT, 0)
	camMover.start()
	set("canPause", false)
	
	GameMusic.stop()
	GameMusic.stream = load(GameSounds.fightEnd)
	
	yield(get_tree().create_timer(1),"timeout")
	
	GameMusic.play()


func _process(delta):
	#var distBtwPlayers = player2.translation.x - player1.translation.x
	
	if beginCameraTracking:
		camera_track_players()


func camera_track_players():
	var distBtwThem = player2.translation.x - player1.translation.x
	
	camera.translation.x = player2.translation.x - distBtwThem / 2
	camera.translation.z = (distBtwThem - initialDistBtwThem) + camTrans
	camera.translation.z = clamp(camera.translation.z, camTrans, camTrans*5)


