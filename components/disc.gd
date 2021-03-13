extends Node2D

class_name Disc, "res://assets/textures/red.png"

# Textures
const red = preload("res://assets/textures/red.png")
const yellow = preload("res://assets/textures/yellow.png")

# Children
onready var img = $Img

# Props
var color: int

func _ready():
	color = GameLogic.get_color_and_switch()
	_decide_texture()

func _decide_texture():
	if color == Constants.RED:
		img.texture = red
	elif color == Constants.YELLOW:
		img.texture = yellow
	else:
		push_error("The input for 'color' is incorrect, should use either Constants.RED or Constants.YELLOW")
