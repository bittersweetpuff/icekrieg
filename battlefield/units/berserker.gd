extends CharacterBody2D

var damage_effect = preload("res://effects/damage_number.tscn")
var dead_effect = preload("res://effects/dead_penguin_effect.tscn")

enum STATE {WALKING, WAITING, ATTACKING}
const SPEED = 80.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@export var team = 1
var direction = 1.0
var max_hp = 60
var hp = 60
var damage = 15
var siege = 1.0
var pushback = 10.0
var current_state = STATE.WALKING
var invincible = false

func _ready():
	pass

func spawn(t):
	team = t
	if team == 2:
		scale.x = -1
		direction = -1.0
	start_walking()
	
func walk():
	velocity.x = move_toward(velocity.x, SPEED*direction, SPEED)
	#velocity.x = direction * SPEED
	move_and_slide()
	
func start_walking():
	$AnimationPlayer.play("Walk")
	current_state = STATE.WALKING
	
func start_attacking():
	current_state = STATE.ATTACKING
	
func check_attack():
	var areas = $Detector.get_overlapping_areas() + $Detector.get_overlapping_bodies()
	var any_enemy = false
	if areas != null:
		for a in areas:
			if a.team != team:
				any_enemy = true
	if any_enemy:
		start_attacking()
	else:
		start_walking()
	
	
	
func attack():
	$AnimationPlayer.play("Attack")

func deal_damage(enemy):
	if enemy.team != team:
		enemy.take_damage(damage, siege, pushback)
	
func destroy():
	print("CASTLE DESTROYED!")
	set_deferred("monitorable", false)
	set_deferred("current_state", STATE.WAITING)
	$AnimationPlayer.call_deferred("stop")
	$Sprite2D.visible = false
	show_dead_effect()
	await get_tree().create_timer(1.0).timeout
	queue_free()

func take_damage(dmg, _s_dmg, _push):
	if hp > 0:
		show_damage_number(dmg)
		hp = max(hp - dmg, 0)
		if(hp == 0):
			destroy()

func show_damage_number(dmg):
	var effect = damage_effect.instantiate()
	add_child(effect)
	effect.position = position
	if team == 2:
		effect.scale.x = -1.0
	effect.show_damage(dmg)

func show_dead_effect():
	var effect = dead_effect.instantiate()
	add_child(effect)
	effect.position = position
	effect.play_effect()
	

func _physics_process(_delta):
	if(current_state == STATE.WALKING):
		walk()
	elif(current_state == STATE.ATTACKING):
		attack()


func _on_detector_area_entered(area):
	if area.team != team:
		
		start_attacking()

func _on_detector_body_entered(body):
	if body.team != team:
		start_attacking()

func _on_hitbox_area_entered(area):
	deal_damage(area)

func _on_hitbox_body_entered(body):
	deal_damage(body)

# Handle end of attack
func _on_animation_player_animation_finished(anim_name):
	if anim_name == "Attack":
		current_state = STATE.WAITING
		$AnimationPlayer.play("Idle")
	if anim_name == "Idle":
		check_attack()


func _on_inv_timer_timeout():
	invincible = false
