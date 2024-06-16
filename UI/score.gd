extends Node

var scores = [0, 0, 0, 0, 0, 0]
var good_hp = 400
var evil_hp = 400
var chillout_mode = false
var music_muted = false
var speed = 1.5

func _ready():
	reset_scores()
	
func reset_scores():
	if chillout_mode:
		scores = [10, 10, 10, 10, 10, 10]
		speed = 1.8
	else:
		scores = [0, 0, 0, 0, 0, 0]
		speed = 1.2
	

func increase_score(color, value):
	scores[color] = min(scores[color] + value, 99)

func decrease_score(color, value):
	scores[color] = max(scores[color] - value, 0)
