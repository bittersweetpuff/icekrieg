extends Node2D

var blink_effect = preload("res://effects/flash_effect.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimationPlayer.play("Show")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _on_animation_player_animation_finished(_anim_name):
	$ChillButton.disabled = false
	$HardcoreButton.disabled = false

func blink():
	var effect = blink_effect.instantiate()
	add_child(effect)
	effect.start_flash()
	
func start_game(insane: bool):
	if insane:
		Score.chillout_mode = false
	else:
		Score.chillout_mode = true
	Score.reset_scores()
	get_tree().change_scene_to_file("res://main.tscn")

func _on_chill_button_pressed():
	start_game(false)
	


func _on_hardcore_button_pressed():
	start_game(true)
