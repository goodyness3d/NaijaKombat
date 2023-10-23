extends AudioStreamPlayer


func _ready():
	var audioFile: AudioStreamSample = load("res://sounds/PUNCH.mp3")
	audioFile.loop_mode = AudioStreamSample.LOOP_DISABLED
	play()
