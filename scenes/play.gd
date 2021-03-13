extends Node2D

class_name PlayScene

# Keep track of all possible positions in the grid
# positions[columns][rows]
# 0 represents an empty position, 1 represents a taken one
const positions = [
	[0, 0, 0, 0, 0, 0],
	[0, 0, 0, 0, 0, 0],
	[0, 0, 0, 0, 0, 0],
	[0, 0, 0, 0, 0, 0],
	[0, 0, 0, 0, 0, 0],
	[0, 0, 0, 0, 0, 0],
	[0, 0, 0, 0, 0, 0]
]

# Children
onready var tween = $Tween as Tween

# Props
const disc = preload("res://components/disc.tscn")
const circle_and_gap_length = 36
export(Array) var column_position_refs
var _disc_scene: Node2D
var _can_click = true

func _on_column_pressed(_event, which_column):
	if Input.is_action_just_pressed("click") and _can_click:
		# Make sure the player is able to put a
		# piece in the selected column
		if positions[which_column][0] == 0:
			_can_click = false
			_add_disc_in_column(which_column)
		else:
			pass # If the column is full

# Add a disc at the specified column
func _add_disc_in_column(nr: int):
	var max_row_index = float(positions[nr].size() - 1)
	# Loop through the entire column from end to beginning (index 5 to 0)
	# If the current position has a '1', go to the next one until there is a '0'
	for row in range(max_row_index, -1, -1):
		if positions[nr][row] == 0:
			positions[nr][row] = 1
			_spawn_disc(nr, row)
			break

func _spawn_disc(col: int, row: int):
	var disc_scene = disc.instance()
	
	# Get the node at the top most circle
	# on the selected column, so we can extract the position
	var col_pos = get_node(column_position_refs[col])
	
	# Set the begin and end positions for the Tween
	# to end animate between
	var initial_pos = col_pos.position + Vector2(0, -56)
	var end_pos = col_pos.position + Vector2(0, circle_and_gap_length * row)
	
	disc_scene.color = GameLogic.get_color_and_switch()
	disc_scene.position = initial_pos
	add_child(disc_scene)
	
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
func _on_tween_completed(object, key):
	_can_click = true
