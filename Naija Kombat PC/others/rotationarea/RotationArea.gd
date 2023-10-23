extends Area

onready var player = get_parent()
func _on_RotationArea_body_entered(body):
	if body !=player and body.has_method("take_damage"):
		player.rotate_z(deg2rad(180))
