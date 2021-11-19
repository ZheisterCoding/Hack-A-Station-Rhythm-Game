extends Node2D

var perfect = false
var good = false
var okay = false
var current_cart = null

export var input = ""

func _ready():
	$AnimatedSprite.frame = 0
	
func _unhandled_input(event):
	if event.is_action(input):
		if event.is_action_pressed(input, false):
			if current_cart != null:
				current_cart.destroy()
		if event.is_action_pressed(input):
			$BurnSound.play()
			if current_cart != null:
				$AnimatedSprite.play("cart-burn")
			else:
				$AnimatedSprite.play("no-burn")
		elif event.is_action_released(input):
			$DelayTimer.start()



func _on_BurnArea_area_entered(area):
	if area.is_in_group("cart"):
		current_cart = area


func _on_BurnArea_area_exited(area):
	if area.is_in_group("cart"):
		current_cart = null


func _on_AnimatedSprite_animation_finished():
	_reset_frame()

func _on_DelayTimer_timeout():
	_reset_frame()
	
func _reset_frame():
	$AnimatedSprite.stop()
	$AnimatedSprite.frame = 0
