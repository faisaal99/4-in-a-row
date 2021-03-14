extends Control

# Constants
const red_win_text = preload("res://assets/hud/red-won.png")
const yellow_win_text = preload("res://assets/hud/yellow-won.png")

# Children
onready var win_message: TextureRect = $VBoxContainer/CenterContainer/WinMessage

# Props
var color_win = -1

func _ready():
	color_win = GameLogic.get_color()
	if color_win == GameLogic.RED:
		win_message.texture = red_win_text
	elif color_win == GameLogic.YELLOW:
		win_message.texture = yellow_win_text
	else:
		push_error("Wrong texture applied")

