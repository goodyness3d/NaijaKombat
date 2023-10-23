extends ScrollContainer


var disabledTexture = "res://others/selectionlists/disabled.png"

onready var buttonGroup = get_tree().get_nodes_in_group("buttons")

signal character_selected
signal locked_character_selected


# Called when the node enters the scene tree for the first time.
func _ready():
	for button in buttonGroup:
		button.connect("pressed", self, "button_pressed", [button.name])
	enable_unlocked_characters()


func enable_unlocked_characters():
	for button in buttonGroup:
		if Characters.unlocked[button.name] == false:
			button.get_parent().texture = load(disabledTexture)


func button_pressed(its_name):
	#print(its_name)
	if Characters.unlocked[its_name] == true:
		emit_signal("character_selected", its_name)
	else:
		emit_signal("locked_character_selected")
