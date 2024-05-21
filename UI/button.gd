extends Node2D

var type = 0
var color = 0
var point_price = 0
var rng = RandomNumberGenerator.new()

signal spawn_button_pressed(unit_type)
	
# Called when the node enters the scene tree for the first time.
func _ready():
	randomize_new_button()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if Score.scores[color] < point_price:
		$Button.disabled = true
	else:
		$Button.disabled = false

func randomize_new_button():
	var random_type = rng.randi_range(0, 100)
	var random_color = rng.randi_range(0, 5)
	if random_type < 30:
		type = 0
		point_price = 8
	elif random_type < 50:
		type = 1
		point_price = 12
	elif random_type < 70:
		type = 2
		point_price = 10
	elif random_type < 90:
		type = 3
		point_price = 16
	else:
		type = 4
		point_price = 25
	color = random_color
	$Price.frame = color
	$Penguin.frame = type
	$Price/Label.text = str(point_price)


func _on_button_pressed():
	Score.decrease_score(color, point_price)
	spawn_button_pressed.emit(type)
	randomize_new_button()
