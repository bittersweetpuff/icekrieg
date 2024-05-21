extends Node2D

var smoke = preload("res://effects/smoke_effect.tscn")
var team = 1
var direction = 1.0
var damage = 5
var siege = 0.3
var pushback = 0

func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func shoot(bullet_damage: int, bullet_siege: int, shooter_team: int, target_pos: Vector2):
	team = shooter_team
	damage = bullet_damage
	siege = bullet_siege
	target_pos.y = position.y
	var tween = get_tree().create_tween()
	tween.tween_property(self, "position", target_pos, 0.5).set_trans(Tween.TRANS_LINEAR)
	tween.tween_callback(queue_free)
	
	
func deal_damage(enemy):
	if enemy.team != team:
		enemy.take_damage(damage, siege, pushback)
		queue_free()
	

func _on_area_2d_area_entered(area):
	deal_damage(area)


func _on_area_2d_body_entered(body):
	deal_damage(body)


	
