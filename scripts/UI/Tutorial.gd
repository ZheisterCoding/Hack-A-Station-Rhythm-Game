extends CanvasLayer

var _frame = 0

func _ready():
	_reset_tutorial_state()

func _on_Tutorial_button_down():
	get_tree().paused = true
	$TutorialPages.visible = true
	
func _input(event):
	if event is InputEventKey:
		if event.is_action_pressed("enter_tutorial") and get_tree().paused == true:
			if _frame < 3:
				$TutorialPages.frame += 1
				_frame += 1
			else:
				_reset_tutorial_state()
				get_tree().paused = false
		elif event.is_action_pressed("escape_tutorial") and get_tree().paused == true:
			_reset_tutorial_state()
			get_tree().paused = false

func _reset_tutorial_state():
	_frame = 0
	$TutorialPages.frame = 0
	$TutorialPages.visible = false
