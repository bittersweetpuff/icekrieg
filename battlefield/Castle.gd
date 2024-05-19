extends Area2D

var damage_effect = preload("res://effects/damage_number.tscn")

@export var team = 1
var max_hp = 500
var hp = 500


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func destroy():
	print("CASTLE DESTROYED!")
	set_deferred("monitorable", false)


func take_damage(damage, siege, pushback):
	if hp > 0:
		hp = max(hp - (damage * siege), 0)
		show_damage_number(damage)
		if(hp == 0):
			destroy()

func show_damage_number(dmg):
	var effect = damage_effect.instantiate()
	add_child(effect)
	effect.position = position
	effect.show_damage(dmg)
		
