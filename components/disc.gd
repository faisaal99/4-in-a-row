extends Node2D

class_name Disc

# Textures
const red = preload("res://assets/textures/red.png")
const yellow = preload("res://assets/textures/yellow.png")

# Children
onready var img = $Img
onready var animation_player = $AnimationPlayer

var color: int

func _ready():
	if color == Constants.RED:
		img.texture = red
	elif color == Constants.YELLOW:
		img.texture = yellow
	else:
		push_error("The 'color' input is incorrect, should use either Constants.RED or Constants.YELLOW")
