extends Sprite2D

@export var tilename: String = ""
var color: int
var grid_pos_x = -99
var grid_pos_y = -99

signal tile_clicked(x, y)

func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _on_tile_pressed():
	tile_clicked.emit(grid_pos_x, grid_pos_y)

func generateNew(clr: int):
	frame = clr
	visible = true
