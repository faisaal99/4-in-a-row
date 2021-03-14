extends Node2D

class_name PlayScene

# Keep track of all possible positions in the grid
# positions[columns][rows]
# -1 represents an empty position, 0 or 1 represents a taken one
const positions = [
	[-1, -1, -1, -1, -1, -1],
	[-1, -1, -1, -1, -1, -1],
	[-1, -1, -1, -1, -1, -1],
	[-1, -1, -1, -1, -1, -1],
	[-1, -1, -1, -1, -1, -1],
	[-1, -1, -1, -1, -1, -1],
	[-1, -1, -1, -1, -1, -1]
]

# Children
onready var tween = $Tween as Tween

# Props
const disc = preload("res://components/disc.tscn")
const circle_and_gap_length = 36
const MAX_COL_INDEX = 6
const MAX_ROW_INDEX = 5

export(Array) var column_position_refs

var _disc_scene: Node2D
var _can_click = true
var _current_col: int
var _current_row: int
var _nr_of_occurrences := 0

func _on_column_pressed(_event, which_column):
	if Input.is_action_just_pressed("click") and _can_click:
		# Make sure the player is able to put a
		# piece in the selected column
		if positions[which_column][0] == -1:
			_can_click = false
			_add_disc_in_column(which_column)
		else:
			pass # If the column is full

# Add a disc at the specified column
func _add_disc_in_column(nr: int):
	var max_row_index = float(positions[nr].size() - 1)
	# Loop through the entire column from end to beginning (index 5 to 0)
	# If the current position has a '-1', put a disc there,
	# otherwise go to next one.
	for row in range(max_row_index, -1, -1):
		if positions[nr][row] == -1:
			positions[nr][row] = GameLogic.get_color()
			_spawn_disc(nr, row)
			_current_col = nr
			_current_row = row
			break

func _spawn_disc(col: int, row: int):
	var disc_scene = disc.instance()
	
	# Get the node at the top most circle
	# on the selected column, so we can extract the position
	var col_pos = get_node(column_position_refs[col])
	
	# Set the begin and end positions for the Tween
	var initial_pos = col_pos.position + Vector2(0, -56)
	var end_pos = col_pos.position + Vector2(0, circle_and_gap_length * row)
	
	# The duration of the fall decreases as the column gets
	# more and more filled
	var fall_duration: float
	match row:
		5, 4:
			fall_duration = 0.5
		3, 2:
			fall_duration = 0.4
		_:
			fall_duration = 0.3
	
	disc_scene.position = initial_pos
	add_child(disc_scene)
	
	tween.interpolate_property(
		disc_scene,
		"position", 
		initial_pos, 
		end_pos, 
		fall_duration, 
		Tween.TRANS_QUAD, 
		Tween.EASE_IN
	)
	tween.start()

# Called when the fall animation stops
# Should calculate if there is a 4 in a row or not
func _on_tween_completed(object, _key):
	var color = object.color
	
	var is_game_over = _check_winner(color)
	
	if is_game_over:
		print("Someone won")
	else:
		_can_click = true

func _check_winner(color):
	var is_vertical = _check_vertical(color)
	var is_horizontal = _check_horizontal(color)
	var is_forw_diagonal = _check_forw_diagonal(color)
	var is_back_diagonal = _check_back_diagonal(color)
	
	if is_vertical or is_horizontal or is_forw_diagonal or is_back_diagonal:
		return true
	return false

func _check_vertical(color):
	_nr_of_occurrences = 0
	for i in range(1, 4):
		if _current_row + i <= 5:
			if positions[_current_col][_current_row + i] == color:
				_nr_of_occurrences += 1
			else:
				break
	if _nr_of_occurrences == 3:
		return true
	return false

func _check_horizontal(color):
	_nr_of_occurrences = 0
	
	# Going right
	for i in range(1, 4):
		if _current_col + i <= 6:
			if positions[_current_col + i][_current_row] == color:
				_nr_of_occurrences += 1
			else:
				break
	# Going left
	for i in range(1, 4):
		print(i)
		if _current_col + i >= 0:
			if positions[_current_col - i][_current_row] == color:
				_nr_of_occurrences += 1
			else:
				break
	if _nr_of_occurrences == 3:
		return true
	return false

# /
func _check_forw_diagonal(color):
	_nr_of_occurrences = 0
	
	# Going up-right
	for i in range(1, 4):
		if _current_col + i <= 6 and _current_row - i >= 0:
			if positions[_current_col + i][_current_row - i] == color:
				_nr_of_occurrences += 1
			else:
				break
	# Going down-left
	for i in range(1, 4):
		if _current_col - i >= 0 and _current_row + i <= 5:
			if positions[_current_col - i][_current_row + i] == color:
				_nr_of_occurrences += 1
			else:
				break
	if _nr_of_occurrences == 3:
		return true
	return false

# \
func _check_back_diagonal(color):
	_nr_of_occurrences = 0
	
	# Going up-left
	for i in range(1, 4):
		if _current_col - i >= 0 and _current_row - i >= 0:
			if positions[_current_col - i][_current_row - i] == color:
				_nr_of_occurrences += 1
			else:
				break
	# Going down-right
	for i in range(1, 4):
		if _current_col + i <= 6 and _current_row + i <= 5:
			if positions[_current_col + i][_current_row + i] == color:
				_nr_of_occurrences += 1
			else:
				break
	if _nr_of_occurrences == 3:
		return true
	return false
