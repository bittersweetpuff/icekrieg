extends Node2D

var button = preload("res://UI/button.tscn")
var distance = 260
signal spawn(type: int)

# Called when the node enters the scene tree for the first time.
func _ready():
	for x in range(4):
		var btn = button.instantiate()
		add_child(btn)
		btn.connect("spawn_button_pressed", _on_spawn_button_pressed)
		btn.position.x = x*distance


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func _on_spawn_button_pressed(type):
	spawn.emit(type)
