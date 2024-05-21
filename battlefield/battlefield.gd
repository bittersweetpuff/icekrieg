extends Node2D

signal castle_destroyed(team)

var infantry = preload("res://battlefield/units/infantry.tscn")
var berserker = preload("res://battlefield/units/berserker.tscn")
var ninja = preload("res://battlefield/units/ninja.tscn")
var shooter = preload("res://battlefield/units/shooter.tscn")
var siege = preload("res://battlefield/units/siege.tscn")

var rng = RandomNumberGenerator.new()

var enemy_resources = 0
var next_enemy = 0
var enemy_costs = [5, 10, 10, 14]
# Called when the node enters the scene tree for the first time.
func _ready():
	$EnemyResourceTimer.start()
	randomize_enemy()



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass



func randomize_enemy():
	var enemy_type = rng.randi_range(0, 3)
	next_enemy = enemy_type
	
func try_enemy_spawn():
	if enemy_resources >= enemy_costs[next_enemy]:
		enemy_resources -= enemy_costs[next_enemy]
		spawn_enemy(next_enemy)
		randomize_enemy()

func spawn_enemy(type):
	if type == 0:
		spawn_penguin(infantry, 2)
	elif type == 1:
		spawn_penguin(berserker, 2)
	elif type == 2:
		spawn_penguin(shooter, 2)
	elif type == 3:
		spawn_penguin(siege, 2)

func call_spawn(type):
	if type == 0:
		spawn_penguin(infantry, 1)
	elif type == 1:
		spawn_penguin(berserker, 1)
	elif type == 2:
		spawn_penguin(shooter, 1)
	elif type == 3:
		spawn_penguin(siege, 1)
	elif type == 4:
		spawn_penguin(ninja, 1)

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
	


func _on_enemy_resource_timer_timeout():
	enemy_resources += 1
	try_enemy_spawn()


func _on_enemy_castle_castle_destroyed():
	castle_destroyed.emit(2)


func _on_good_castle_castle_destroyed():
	castle_destroyed.emit(1)
