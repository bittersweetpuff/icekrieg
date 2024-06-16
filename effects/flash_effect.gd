extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func play_effect():
	$AnimationPlayer.play("Play")

func start_flash():
	$AnimationPlayer.play("Start")
	
func end_flash():
	$AnimationPlayer.play("End")


func _on_animation_player_animation_finished(_anim_name):
	queue_free()
