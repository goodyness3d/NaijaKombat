extends Node



var graphicsMode = "low"
var gameMode = ""
var difficulty = "normal"
var loadingScreenText = ""
var storyModeProgress = 0
var grudgeFightProgress = 0
var completedStoryMode = false

onready var optionsMenu = preload("res://others/optionsmenu/OptionsMenu.tscn")
onready var pauseOptionsMenu = preload("res://others/pausemenu/PauseMenuOptions.tscn")

var parentViewport:Viewport


func goto_scene(currentScene, path):
	var viewport = currentScene.get_parent()
	var loader = ResourceLoader.load_interactive(path)
	
	if loader == null:
		return
	
	var loadingScene = load("res://others/loadingscreen/LoadingScreen.tscn").instance()
	viewport.call_deferred("add_child", loadingScene)
	
	while true:
		var err = loader.poll()
		
		if err == ERR_FILE_EOF:
			#loading is complete
			var resource = loader.get_resource().instance()
			viewport.call_deferred("add_child", resource)
			
			currentScene.queue_free()
			loadingScene.queue_free()
			
			break
		
		yield(get_tree(), "idle_frame")


func show_options_menu(current_scene, its_name):
	if its_name == "main":
		current_scene.add_child(optionsMenu.instance())
	if its_name == "pause":
		current_scene.add_child(pauseOptionsMenu.instance())


func save_game():
	var saveDict = {
		"progress":storyModeProgress, 
		"complete":completedStoryMode, 
		"unlocked characters":Characters.unlocked,
		"unlocked venues":Venues.unlocked,
		"difficulty":difficulty,
		"graphicsMode":graphicsMode
	}
	
	var saveFile = File.new()
	saveFile.open("user://savegame.sav", File.WRITE)
	saveFile.store_line(to_json(saveDict))
	saveFile.close()


func load_game():
	var loadFile = File.new()
	
	if not loadFile.file_exists("user://savegame.sav"):
		return
	
	loadFile.open("user://savegame.sav", File.READ)
	
	var loadData = parse_json(loadFile.get_line())
	
	set("storyModeProgress", loadData["progress"])
	set("completedStoryMode", loadData["complete"])
	set("difficulty", loadData["difficulty"])
	set("graphicsMode", loadData["graphicsMode"])
	
	Characters.unlocked = loadData["unlocked characters"]
	Venues.unlocked = loadData["unlocked venues"]
