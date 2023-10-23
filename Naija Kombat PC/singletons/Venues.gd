extends Node


var selected = ["Market"]

var previous = ""

var paths = {
	"AmaechiRailway":"res://venues/AmaechiRailway/AmaechiRailway.tscn",
	"ArtilleryFlyover":"res://venues/ArtilleryFlyover/ArtilleryFlyover.tscn",
	"AzikiweAirport":"res://venues/AzikiweAirport/AzikiweAirport.tscn",
	"DarkRoom":"res://venues/DarkRoom/DarkRoom.tscn",
	"InterrogationRoom":"res://venues/InterrogationRoom/InterrogationRoom.tscn",
	"LekkiTollgate":"res://venues/LekkiTollgate/LekkiTollgate.tscn",
	"Market":"res://venues/Market/Market.tscn",
	"MilitaryBase":"res://venues/MilitaryBase/MilitaryBase.tscn",
	"MoneyRoom":"res://venues/MoneyRoom/MoneyRoom.tscn",
	"PresidosVilla":"res://venues/PresidosVilla/PresidosVilla.tscn",
	"RadioBiafra":"res://venues/RadioBiafra/RadioBiafra.tscn",
	"RajiFasholaEstate":"res://venues/RajiFasholaEstate/RajiFasholaEstate.tscn",
	"Sambisa":"res://venues/Sambisa/Sambisa.tscn",
	"SenateHouse":"res://venues/SenateHouse/SenateHouse.tscn",
	"StudentLodge":"res://venues/StudentLodge/StudentLodge.tscn"
}


var unlocked = {
	"AmaechiRailway":true,
	"ArtilleryFlyover":true,
	"AzikiweAirport":false,
	"DarkRoom":true,
	"InterrogationRoom":false,
	"LekkiTollgate":false,
	"Market":true,
	"MilitaryBase":false,
	"MoneyRoom":false,
	"PresidosVilla":false,
	"RadioBiafra":false,
	"RajiFasholaEstate":true,
	"Sambisa":true,
	"SenateHouse":false,
	"StudentLodge":false
}


func _ready():
	pass#randomize()
	#var plyrlist = paths.keys()
	#plyrlist.shuffle()
	#selected = [plyrlist[2]]
