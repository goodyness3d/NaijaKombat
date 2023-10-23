extends ColorRect


var firstFight = "res://others/grudgefights/textures/Amaechi_vs_Wike.png"
var secondFight = "res://others/grudgefights/textures/Reno_vs_Buratai.png"
var thirdFight = "res://others/grudgefights/textures/LazyYouth_vs_PMB.png"
var fourthFight = "res://others/grudgefights/textures/YahooBoy_vs_FSars.png"
var fifthFight = "res://others/grudgefights/textures/Nnamdi_vs_PMB.png"


var textureList = [
	firstFight,
	secondFight,
	thirdFight,
	fourthFight,
	fifthFight
]

var fightingVenues = [
	"ArtilleryFlyover",
	"DarkRoom",
	"PresidosVilla",
	"StudentLodge",
	"PresidosVilla"
]


func _ready():
	$TextureRect.texture = load(textureList[SceneChanger.grudgeFightProgress])


func set_P1_and_P2():
	var progress = SceneChanger.grudgeFightProgress
	
	if progress == 0:
		Characters.selected[0] = "Amaechi"
		Characters.selected[1] = "Wike"
		Venues.selected[0] = fightingVenues[progress]
	
	elif progress == 1:
		Characters.selected[0] = "Reno"
		Characters.selected[1] = "Buratai"
		Venues.selected[0] = fightingVenues[progress]
	
	elif progress == 2:
		Characters.selected[0] = "LazyYouth"
		Characters.selected[1] = "PMB"
		Venues.selected[0] = fightingVenues[progress]
	
	elif progress == 3:
		Characters.selected[0] = "YahooBoy"
		Characters.selected[1] = "FSars"
		Venues.selected[0] = fightingVenues[progress]
	
	else:
		Characters.selected[0] = "Nnamdi"
		Characters.selected[1] = "PMB"
		Venues.selected[0] = fightingVenues[progress]


func goto_fighting_venue():
	var progress = SceneChanger.grudgeFightProgress
	
	SceneChanger.loadingScreenText = fightingVenues[progress]
	
	SceneChanger.goto_scene(self, Venues.paths[Venues.selected[0]])
