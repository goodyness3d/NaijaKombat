extends TouchScreenButton


var radius = Vector2(48,48)
var boundary = 82
var boundary2 = 200

var ongoingDrag = -1
var retuurnAccel = 20

var threshold = 10

func _process(delta):
	if ongoingDrag == -1:
		var posDifference = (Vector2(0,0) - radius) - position
		position += posDifference * retuurnAccel * delta

func get_button_position():
	return position + radius

func _input(event):
	if event is InputEventScreenDrag or (event is InputEventScreenTouch and event.is_pressed()):
		var eventDistFromCentre = (event.position - get_parent().global_position).length()
		
		if eventDistFromCentre <= boundary * global_scale.x or event.get_index() == ongoingDrag:
			set_global_position( event.position - radius * global_scale )
		
			if get_button_position().length() > boundary:
				set_position( get_button_position().normalized() * boundary - radius )
		
			ongoingDrag = event.get_index()
	
	if event is InputEventScreenTouch and !event.is_pressed() and event.get_index() == ongoingDrag:
		ongoingDrag = -1

func  get_value():
	if get_button_position().length > threshold:
		return get_button_position().normalized()
	return Vector2(0,0)
