extends Node



var isWinner = false
var lowHealth = 40
var selectPlayer = 0
var numberOfPlayers = 1
var previewerPaths
var hasLoadedPreviewer = false

var selected = ["Akpabio", "PMB"]

var paths = {
	"Akpabio":"res://characters tscn/Akpabio.tscn",
	"Amaechi":"res://characters tscn/Amaechi.tscn",
	"BM Bruce":"res://characters tscn/BMB.tscn",
	"Buratai":"res://characters tscn/Buratai.tscn",
	"DSS":"res://characters tscn/DSS.tscn",
	"FSars":"res://characters tscn/FSars.tscn",
	"Fashola":"res://characters tscn/Fashola.tscn",
	"FemiFani":"res://characters tscn/FemiFani.tscn",
	"Ikpeazu":"res://characters tscn/Ikpeazu.tscn",
	"Lai":"res://characters tscn/Lai.tscn",
	"LazyYouth":"res://characters tscn/LazyYouth.tscn",
	"Nnamdi":"res://characters tscn/Nnamdi.tscn",
	"Obaseki":"res://characters tscn/Obaseki.tscn",
	"Osinbajo":"res://characters tscn/Osinbajo.tscn",
	"PMB":"res://characters tscn/PMB.tscn",
	"Reno":"res://characters tscn/Reno.tscn",
	"Rochas":"res://characters tscn/Rochas.tscn",
	"Saraki":"res://characters tscn/Saraki.tscn",
	"Tinubu":"res://characters tscn/Tinubu.tscn",
	"Wike":"res://characters tscn/Wike.tscn",
	"YahooBoy":"res://characters tscn/YahooBoy.tscn"
}

var unlocked = {
	"Akpabio":false,
	"Amaechi":false,
	"BM Bruce":true,
	"Buratai":false,
	"DSS":false,
	"FSars":false,
	"Fashola":false,
	"FemiFani":true,
	"Ikpeazu":false,
	"Lai":false,
	"LazyYouth":true,
	"Nnamdi":false,
	"Obaseki":true,
	"Osinbajo":false,
	"PMB":false,
	"Reno":true,
	"Rochas":false,
	"Saraki":false,
	"Tinubu":false,
	"Wike":false,
	"YahooBoy":true
	}


func _ready():
	randomize()


func has_died(player_name, player, current_scene):
	var screen = CanvasLayer.new()
	var winScreen = load("res://others/winscreen/WinScreen.tscn").instance()
	
	if player_name == selected[0] and player.isPlayer == true:
		isWinner = false
		winScreen.text = selected[1] + " " + "wins"
	
	elif player_name == selected[1] and player.isEnemy == true:
		isWinner = true
		winScreen.text = selected[0] + " " + "wins"
		
		if SceneChanger.gameMode == "story" and SceneChanger.storyModeProgress <= 14:
			SceneChanger.storyModeProgress += 1
			
			unlocked[player_name] = true
			Venues.unlocked[Venues.selected[0]] = true
	
	screen.add_child(winScreen)
	current_scene.add_child(screen)


func show_touch_controls(current_scene):
	var controller = load("res://controllers/touch controls/Touchcontrols.tscn").instance()
	current_scene.add_child(controller)


func show_bloodshot(scene):
	var blood = load("res://others/bloodshot/Bloodshot.tscn").instance()
	scene.add_child(blood)


func load_previewer_paths():
	hasLoadedPreviewer = true
	
	previewerPaths = {
		"Akpabio":load(paths["Akpabio"]),
		"Amaechi":load(paths["Amaechi"]),
		"BM Bruce":load(paths["BM Bruce"]),
		"Buratai":load(paths["Buratai"]),
		"DSS":load(paths["DSS"]),
		"FSars":load(paths["FSars"]),
		"Fashola":load(paths["Fashola"]),
		"FemiFani":load(paths["FemiFani"]),
		"Ikpeazu":load(paths["Ikpeazu"]),
		"Lai":load(paths["Lai"]),
		"LazyYouth":load(paths["LazyYouth"]),
		"Nnamdi":load(paths["Nnamdi"]),
		"Obaseki":load(paths["Obaseki"]),
		"Osinbajo":load(paths["Osinbajo"]),
		"PMB":load(paths["PMB"]),
		"Reno":load(paths["Reno"]),
		"Rochas":load(paths["Rochas"]),
		"Saraki":load(paths["Saraki"]),
		"Tinubu":load(paths["Tinubu"]),
		"Wike":load(paths["Wike"]),
		"YahooBoy":load(paths["YahooBoy"])
		}


func randomSelect():
	randomize()
	#var plyrlist = paths.keys()
	#plyrlist.shuffle()
	#selected = [plyrlist[2], plyrlist[3]]
