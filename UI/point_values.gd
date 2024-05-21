extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	$Color1/Label.text = str(Score.scores[0])
	$Color2/Label.text = str(Score.scores[1])
	$Color3/Label.text = str(Score.scores[2])
	$Color4/Label.text = str(Score.scores[3])
	$Color5/Label.text = str(Score.scores[4])
	$Color6/Label.text = str(Score.scores[5])
