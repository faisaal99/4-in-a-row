extends Control

# Children
onready var play_button = $CenterContainer/VBoxContainer/PlayButton
onready var highlight = $CenterContainer/VBoxContainer/PlayButton/Highlight

# Props
signal signal_start_game

func _on_PlayButton_pressed():
	emit_signal("signal_start_game")
	visible = false


func _on_play_button_hover():
	print("Hover")
	highlight.visible = true


func _on_play_button_exit_hover():
	print("Hover Exit")
	highlight.visible = false
