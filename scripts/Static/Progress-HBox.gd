extends Node2D

var _progress_capacity

func _ready():
	$TextureProgress.value = 0

func _on_Progress_changed(by):
	var current = $TextureProgress.value
	var new = $TextureProgress.value + (float(by)/_progress_capacity * 100)
	_animate_value(current, new)
	

func _animate_value(start, end):
	$Tween.interpolate_property($TextureProgress, "value", start, end, 0.1, Tween.TRANS_CUBIC, Tween.EASE_OUT)
	$Tween.start()


func _on_Level_update_score_label(score):
	$Score.text = str(score)
	
func _on_Level_set_capacity(capacity):
	_progress_capacity = capacity
