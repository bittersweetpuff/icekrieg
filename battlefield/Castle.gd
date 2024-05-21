extends Area2D

var damage_effect = preload("res://effects/damage_number.tscn")

@export var team = 1
var max_hp = 400
var hp = 400

signal castle_destroyed()


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func destroy():
	castle_destroyed.emit()
	set_deferred("monitorable", false)


func take_damage(damage, siege, _pushback):
	if hp > 0:
		var act_damage = damage * siege
		hp = max(hp - act_damage, 0)
		show_damage_number(act_damage)
		if(hp == 0):
			destroy()

func show_damage_number(dmg):
	var effect = damage_effect.instantiate()
	add_child(effect)
	effect.position = position
	effect.show_damage(dmg)
		
