extends Node

var scores = [0, 0, 0, 0, 0, 0]
var good_hp = 400
var evil_hp = 400
var chillout_mode = false
var music_muted = false

func _ready():
	reset_scores()
	
func reset_scores():
	#scores = [0, 0, 0, 0, 0, 0]
	scores = [99, 99, 99, 99, 99, 99]
	

func increase_score(color, value):
	scores[color] = min(scores[color] + value, 99)

func decrease_score(color, value):
	scores[color] = max(scores[color] - value, 0)
