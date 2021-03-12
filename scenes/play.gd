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

func _on_column_pressed(event, which_button):
	if Input.is_action_just_pressed("click"):
		# Make sure the player is able to put a
		# piece in the selected column
		if positions[which_button][0] == 0:
			_add_disc_in_column(which_button)
		else:
			print("The column is filled")

func _add_disc_in_column(nr: int):
	
	var max_index = float(positions[nr].size() - 1)
	# Loop through the entire column from end to beginning (index 5 to 0)
	# If the current position has a '1', go to the next one until there is a '0'
	for col in range(max_index, -1, -1):
		if positions[nr][col] == 0:
			positions[nr][col] = 1
			break
	
	print(positions[nr])
