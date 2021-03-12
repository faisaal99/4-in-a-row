extends Node2D

class_name Disc

# Textures
const red = preload("res://assets/textures/red.png")
const yellow = preload("res://assets/textures/yellow.png")

# Children
onready var img = $Img
onready var animation_player = $AnimationPlayer as AnimationPlayer

# Props
var color: int
var _anim_end_position: int

func _ready():
	_decide_texture()

func _decide_texture():
	if color == Constants.RED:
		img.texture = red
	elif color == Constants.YELLOW:
		img.texture = yellow
	else:
		push_error("The 'color' input is incorrect, should use either Constants.RED or Constants.YELLOW")

# Call this method from PlayScene
# Don't use _create_animation() directly
func play_fall_animation():
	_create_animation()

func _create_animation():
	var anim = animation_player.get_animation("disc_fall")
	if anim != null:
		print("Animation found!")
	else:
		print("Animation is null")
