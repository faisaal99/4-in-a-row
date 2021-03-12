extends Control

# Children
onready var play_button = $CenterContainer/VBoxContainer/PlayButton

# Props
signal signal_start_game




func _on_PlayButton_pressed():
	emit_signal("signal_start_game")
	visible = false
