extends Node2D

func _ready():
	$EndMusic.play()
	$TweenTimer.start()
	if Global.level_passed:
		$EndScreen.frame = 0
	else:
		$EndScreen.frame = 1
	_set_scoreboard()


func _on_TweenTimer_timeout():
	$EndTween.interpolate_property($TextureProgress, "value", 0, float(Global.score)/Global.progress_capacity * 100, 4, Tween.TRANS_CUBIC, Tween.EASE_OUT)
	$EndTween.start()
	$Continue.visible = true

func _set_scoreboard():
	$MinOneCount.text = str(Global.min_one_count)
	$MinThreeCount.text = str(Global.min_three_count)
	$PlusCount.text = str(Global.plus_count)
	$Score.text = str(Global.score)

func _on_Continue_button_down():
	$EndMusic.stop()
	if $Continue.visible:
		if get_tree().change_scene("res://scenes/UI/Menu.tscn") != OK:
			printerr("Failed to return to Home screen")
