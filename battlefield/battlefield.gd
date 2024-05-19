extends Node2D

var infantry = preload("res://battlefield/units/infantry.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	spawn_penguin(infantry, 1)
	spawn_penguin(infantry, 2)
	await get_tree().create_timer(1.0).timeout
	spawn_penguin(infantry, 1)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func spawn_penguin(p_type, team):
	var penguin = p_type.instantiate()
	var pos
	if team == 1:
		pos = $SpawnAlly.position
	else:
		pos = $SpawnEnemy.position
	
	# Spawn Here
	add_child(penguin)
	penguin.position = pos
	penguin.spawn(team)
	
