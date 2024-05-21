extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func play_effect():
	var root = get_tree().root
	var main_scene = root.get_child(root.get_child_count() - 1)
	get_parent().remove_child(self)
	main_scene.add_child(self)
	self.set_owner(main_scene)
	$AnimationPlayer.play("Play")


func _on_animation_player_animation_finished(_anim_name):
	queue_free()
