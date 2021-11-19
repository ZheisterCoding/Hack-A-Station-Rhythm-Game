extends Control

func _input(event):
	if event.is_action_pressed("pause"):
		$PauseSound.play()
		get_tree().paused = true
		visible = true


func _on_Continue_button_down():
	$ContinueSound.play()
	get_tree().paused = false
	visible = false


func _on_Quit_button_down():
	get_tree().paused = false
	if get_tree().change_scene("res://scenes/UI/Menu.tscn") != OK:
		printerr("Failed to return to Menu scene")
