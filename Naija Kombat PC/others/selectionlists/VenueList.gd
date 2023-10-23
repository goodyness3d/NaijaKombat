extends ScrollContainer


var disabledTexture = "res://others/selectionlists/disabled_venue.png"

onready var buttonGroup = get_tree().get_nodes_in_group("vbuttons")

signal venue_selected
signal locked_venue_selected


func _ready():
	for button in buttonGroup:
		button.connect("pressed", self, "button_pressed", [button.name])
	enable_unlocked_venues()


func enable_unlocked_venues():
	for button in buttonGroup:
		if Venues.unlocked[button.name] == false:
			button.get_parent().texture = load(disabledTexture)


func button_pressed(its_name):
	#print(its_name)
	if Venues.unlocked[its_name] == true:
		emit_signal("venue_selected", its_name)
	else:
		emit_signal("locked_venue_selected")

