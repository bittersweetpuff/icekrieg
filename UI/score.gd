extends Node

var scores = [0, 0, 0, 0, 0, 0]

func _ready():
	reset_scores()
	
func reset_scores():
	scores = [0, 0, 0, 0, 0, 0]
	

func increase_score(color, value):
	scores[color] = min(scores[color] + value, 99)

func decrease_score(color, value):
	scores[color] = max(scores[color] - value, 0)
