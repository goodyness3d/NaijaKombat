extends MarginContainer


onready var fightingVenue = get_parent()

onready var timeLabel = $VBoxContainer/Control/Label
onready var timer = $Timer


func _process(delta):
	timeLabel.text = str(int(timer.time_left))


func _on_Timer_timeout():
	fightingVenue.pop
