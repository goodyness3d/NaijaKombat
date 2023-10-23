extends Spatial


signal headhit
signal groinhit
signal leghit

onready var player = get_parent().get_node("AttackArea")


func _on_HeadArea_area_entered(area):
	if area == player:
		pass
	elif area.has_method("cause_damage"):
		emit_signal("headhit")
		GameSounds.currentSound = GameSounds.headSound


func _on_GroinArea_area_entered(area):
	if area == player:
		pass
	elif area.has_method("cause_damage"):
		emit_signal("groinhit")
		GameSounds.currentSound = GameSounds.groinSound


func _on_LegArea_area_entered(area):
	if area == player:
		pass
	elif area.has_method("cause_damage"):
		emit_signal("leghit")
		GameSounds.currentSound = GameSounds.legSound
