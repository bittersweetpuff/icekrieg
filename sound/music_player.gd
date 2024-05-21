extends AudioStreamPlayer


# Called when the node enters the scene tree for the first time.
func _ready():
	pass
		


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func start_playing():
	if playing != true:
		playing = true
