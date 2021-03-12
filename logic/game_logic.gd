extends Node

enum {
	RED, YELLOW
}

# Variable for keeping track of
# which player is playing
# DON'T USE DIRECTLY, USE METHOD INSTEAD
var _current_player = RED

func get_color_and_switch():
	var cp = _current_player
	_switch_player()
	return cp

func _switch_player():
	if _current_player == RED:
		_current_player = YELLOW
	else:
		_current_player = RED
