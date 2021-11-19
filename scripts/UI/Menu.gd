extends Control

func _ready():
	$StartMusic.play()
	
func _on_LevelOne_pressed():
	$StartMusic.stop()
	$ButtonSound.play()
	if get_tree().change_scene("res://scenes/Levels/LevelTemplate.tscn") != OK:
		printerr("Failed to proceed to Level One")


func _on_LevelTwo_pressed():
	$StartMusic.stop()
	$ButtonSound.play()
	if get_tree().change_scene("res://scenes/Levels/Level2.tscn") != OK:
		printerr("Failed to proceed to Level One")
