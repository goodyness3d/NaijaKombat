extends TextureProgress

var bigLife = (max_value/2) + (max_value/4)
var halfLife = max_value/2
var lowLife = max_value/3

func _process(delta):
	set_bar_color()

func set_bar_color():
	if value > bigLife:
		set_tint_progress(Color(0.2, 0.72, 0.08, 1))
	elif value > halfLife:
		set_tint_progress(Color(0.63, 0.72, 0.08, 1))
	elif value > lowLife:
		set_tint_progress(Color(0.72, 0.64, 0.08, 1))
	else:
		set_tint_progress(Color(0.89, 0.09, 0.09, 1))
