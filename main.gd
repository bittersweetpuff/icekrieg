extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
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


func _on_spawn_buttons_spawn(type):
	$BattleFieldContainer/SubViewport/Battlefield.call_spawn(type)

func _on_battlefield_castle_destroyed(team):
	if team == 1:
		print("YOU LOSE!")
	else:
		print("YOU WIN!")
	


func _on_reset_button_pressed():
	get_tree().reload_current_scene() 


func _on_mute_button_toggled(toggled_on):
	var bus_idx = AudioServer.get_bus_index("Master")
	if toggled_on:
		AudioServer.set_bus_mute(bus_idx, true) # or false
	else:
		AudioServer.set_bus_mute(bus_idx, false) # or false
