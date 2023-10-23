extends Node


var soundIsEnabled = true
var musicIsEnabled = true

var mainMenu = "res://sounds/mainmenu.ogg"
var storyMode = "res://sounds/storymode.ogg"
var grudgeFight = "res://sounds/grudgefight.ogg"

var headSound = "res://sounds/jesu.wav"
var groinSound = "res://sounds/funke.wav"
var legSound = "res://sounds/apostle_will_hear_of_this.wav"

var fightStart = "res://sounds/boxing_bell.wav"
var fightEnd = "res://sounds/you're_a_mumu_man.wav"

var currentSound = ""

var soundsToShuffle = [headSound, groinSound, legSound]

func shuffle_sounds():
	soundsToShuffle.shuffle()
	
	currentSound = soundsToShuffle[0]
