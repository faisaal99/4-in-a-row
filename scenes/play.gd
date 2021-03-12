extends Node2D



func _on_column_pressed(event, which_button):
	if Input.is_action_just_pressed("click"):
		print("#{nr} pressed".format({"nr": which_button}))
