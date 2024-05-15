extends Node2D

@onready var rng = RandomNumberGenerator.new()

var tile = preload("res://match3/match_3_tile.tscn")

var tile_grid: Array[Array]
var tiles: Array[Array]
var grid_size = 5
var tile_size = 192

# Called when the node enters the scene tree for the first time.
func _ready():
	setup_grid()
	initialize_grid()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func place_tile(tile_to_place, x: int, y: int) -> void:
	tile_to_place.grid_pos_x = x
	tile_to_place.grid_pos_y = y
	tile_to_place.position = Vector2(x * tile_size, y * tile_size)

func setup_grid() -> void:
	for i in range(grid_size):
		tile_grid.append([]) 
		tiles.append([]) 
		for j in range(grid_size):
			#Append with -1 for empty
			tile_grid[i].append(-1)

func initialize_grid() -> void:

	for i in range(grid_size):
		for j in range(grid_size):
			var color = rng.randi_range(0, 5)
			tile_grid[i][j] = color
			var newTile = tile.instantiate()
			add_child(newTile)
			newTile.generateNew(color)
			newTile.connect("tile_clicked", _on_grid_tile_clicked)
			tiles[i].append(newTile)
			place_tile(newTile, i, j)
			
			
func _on_grid_tile_clicked(x, y):
	tile_pressed(x, y)
	
func tile_pressed(x, y):
	var color = tile_grid[x][y]
	check_for_delete(x, y, color)
	claim_tiles()
	repopulate_grid()


func get_tile(x, y):
	return tiles[x][y]


func delete_tile(x, y):
	var tile = get_tile(x, y)
	if tile != null:
		tile.queue_free()
	
func check_for_delete(x: int, y: int, color: int):
	if(tile_grid[x][y] == color):
		tile_grid[x][y] = -1
		if(x > 0):
			check_for_delete(x-1, y, color)
		if(x < grid_size - 1):
			check_for_delete(x+1, y, color)
		if(y > 0):
			check_for_delete(x, y - 1, color)
		if(y < grid_size - 1):
			check_for_delete(x, y + 1, color)
		return
	else:
		return


func move_tile(old_x, old_y, new_x, new_y):
	var tile = get_tile(old_x, old_y)
	if tile != null:
		tile_grid[new_x][new_y] = tile_grid[old_x][old_y]
		tile_grid[old_x][old_y] = -1
		slide_tile(tile, new_x, new_y)
		tiles[new_x][new_y] = tiles[old_x][old_y]
		tiles[old_x][old_y] = null
	
func slide_tile(tile, x, y):
	var tween = get_tree().create_tween()
	tween.tween_property(tile, "position", Vector2(x * tile_size, y * tile_size), 0.8)
	tile.grid_pos_x = x
	tile.grid_pos_y = y

func claim_tiles():
	for x in range(grid_size):
		for y in range(grid_size):
			if tile_grid[x][y] == -1:
				delete_tile(x, y)
				
func spawn_and_slide_to(x, y):
	var spawn_x = x * tile_size
	var spawn_y = (y * tile_size) - 960
	var newTile = tile.instantiate()
	var color = rng.randi_range(0, 5)
	newTile.position = Vector2(spawn_x, spawn_y)
	add_child(newTile)
	newTile.generateNew(color)
	newTile.connect("tile_clicked", _on_grid_tile_clicked)
	tile_grid[x][y] = color
	tiles[x][y] = newTile
	slide_tile(newTile, x, y)

func repopulate_grid():
	print("repopulating")
	for x in range(0, 5):
		for y in range(4, -1, -1):
			if tile_grid[x][y] == -1:
				print("empty tile at", x, y)
				for n_y in range(y, -1, -1):
					if tile_grid[x][n_y] != -1:
						move_tile(x, n_y, x, y)
						break
					elif n_y == 0:
						spawn_and_slide_to(x, y)
						break
