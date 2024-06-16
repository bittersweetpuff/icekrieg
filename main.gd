extends Node2D

var blink_effect = preload("res://effects/flash_effect.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	Score.reset_scores()
	blink_fade()
	var bus_idx = AudioServer.get_bus_index("Master")
	if Score.music_muted == true:
		$MuteButton.button_pressed = true
		AudioServer.set_bus_mute(bus_idx, true)
	else:
		$MuteButton.button_pressed = false
		AudioServer.set_bus_mute(bus_idx, false)
	MusicPlayer.start_playing()




# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func blink_start():
	var effect = blink_effect.instantiate()
	add_child(effect)
	effect.start_flash()
	
func blink_fade():
	var effect = blink_effect.instantiate()
	add_child(effect)
	effect.end_flash()

func show_end_screen(win: bool):
	if win:
		$EndGameScreen/Result/Vicotry.visible = true
	else:
		$EndGameScreen/Result/Defeat.visible = true
	$EndGameScreen/AnimationPlayer.play("Show")
	$EndGameScreen.visible = true
	$EndGameScreen/PlayAgainButton.disabled = false

func _on_spawn_buttons_spawn(type):
	$BattleFieldContainer/SubViewport/Battlefield.call_spawn(type)

func _on_battlefield_castle_destroyed(team):
	if team == 1:
		show_end_screen(false)
	else:
		show_end_screen(true)
	


func _on_reset_button_pressed():
	reset_game()


func reset_game():
	get_tree().reload_current_scene() 


func _on_mute_button_toggled(toggled_on):
	var bus_idx = AudioServer.get_bus_index("Master")
	if toggled_on:
		Score.music_muted = true
		AudioServer.set_bus_mute(bus_idx, true) # or false
	else:
		Score.music_muted = false
		AudioServer.set_bus_mute(bus_idx, false) # or false


func _on_play_again_button_pressed():
	reset_game()
