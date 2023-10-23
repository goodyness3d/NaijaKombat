extends ColorRect



var Akpabio = "res://others/storymode/textures/Akpabio.png"
var Amaechi = "res://others/storymode/textures/Amaechi.png"
var Buratai = "res://others/storymode/textures/Buratai.png"
var DSS = "res://others/storymode/textures/DSS.png"
var Fashola = "res://others/storymode/textures/Fashola.png"
var FSars = "res://others/storymode/textures/FSars.png"
var Ikpeazu = "res://others/storymode/textures/Ikpeazu.png"
var Lai = "res://others/storymode/textures/Lai.png"
var Nnamdi = "res://others/storymode/textures/Nnamdi.png"
var Osinbajo = "res://others/storymode/textures/Osinbajo.png"
var PMB = "res://others/storymode/textures/PMB.png"
var Rochas = "res://others/storymode/textures/Rochas.png"
var Saraki = "res://others/storymode/textures/Saraki.png"
var Tinubu = "res://others/storymode/textures/Tinubu.png"
var Wike = "res://others/storymode/textures/Wike.png"


var textureList = [
	Akpabio,
	Fashola,
	Ikpeazu,
	Wike,
	Amaechi,
	Rochas,
	Saraki,
	FSars,
	Osinbajo,
	Nnamdi,
	Lai,
	DSS,
	Tinubu,
	Buratai,
	PMB
]


var nameList = [
	"Akpabio",
	"Fashola",
	"Ikpeazu",
	"Wike",
	"Amaechi",
	"Rochas",
	"Saraki",
	"FSars",
	"Osinbajo",
	"Nnamdi",
	"Lai",
	"DSS",
	"Tinubu",
	"Buratai",
	"PMB"
]


var venuesList = [
	"AzikiweAirport",
	"RajiFasholaEstate",
	"Market",
	"ArtilleryFlyover",
	"AmaechiRailway",
	"MoneyRoom",
	"SenateHouse",
	"StudentLodge",
	"SenateHouse",
	"RadioBiafra",
	"SenateHouse",
	"InterrogationRoom",
	"LekkiTollgate",
	"MilitaryBase",
	"PresidosVilla"
]


func _ready():
	$TextureRect.texture = load(textureList[SceneChanger.storyModeProgress])
	$Label.text = nameList[SceneChanger.storyModeProgress]


func set_enemy_and_venue():
	Venues.selected[0] = venuesList[SceneChanger.storyModeProgress]
	Characters.selected[1] = nameList[SceneChanger.storyModeProgress]


func goto_fighting_venue():
	SceneChanger.loadingScreenText = venuesList[SceneChanger.storyModeProgress]
	SceneChanger.goto_scene(self, Venues.paths[Venues.selected[0]])

