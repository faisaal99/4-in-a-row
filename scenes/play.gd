extends Node2D

# Keep track of all possible positions in the grid
# positions[columns][rows]
const positions = [
	[0, 0, 0, 0, 0, 0],
	[0, 0, 0, 0, 0, 0],
	[0, 0, 0, 0, 0, 0],
	[0, 0, 0, 0, 0, 0],
	[0, 0, 0, 0, 0, 0],
	[0, 0, 0, 0, 0, 0],
	[0, 0, 0, 0, 0, 0]
]

# Props
const disc = preload("res://components/disc.tscn")
export(Array) var column_position_refs

func _on_column_pressed(_event, which_button):
	if Input.is_action_just_pressed("click"):
		# Make sure the player is able to put a
		# piece in the selected column
		if positions[which_button][0] == 0:
			_add_disc_in_column(which_button)
		else:
			print("The column is filled")

# Add a disc at the specified column
func _add_disc_in_column(nr: int):
	var max_index = float(positions[nr].size() - 1)
	# Loop through the entire column from end to beginning (index 5 to 0)
	# If the current position has a '1', go to the next one until there is a '0'
	for row in range(max_index, -1, -1):
		if positions[nr][row] == 0:
			positions[nr][row] = 1
			_spawn_disc(nr, row)
			break

func _spawn_disc(col: int, row: int):
	var disc_scene = disc.instance() as Disc
	var position_col = get_node(column_position_refs[col])
	
	disc_scene.color = Constants.RED
	disc_scene.position = position_col.position - Vector2(0, 56)
	
	add_child(disc_scene)
