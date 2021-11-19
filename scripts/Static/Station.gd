extends Node2D

signal progress_bar_changed(by)

func _on_MiddleDoor_area_entered(area):
	if area.is_in_group("cart"):
		if "plus" in area.cart_type:
			$PlusSound.play()
			get_parent().plus_count += 1
			get_parent().score += 1
			emit_signal("progress_bar_changed", 1)
		else:
			$MinusSound.play()
			if "minus_one" in area.cart_type:
				get_parent().min_one_count += 1
				get_parent().score += -1
				emit_signal("progress_bar_changed", -1)
			elif "minus_three" in area.cart_type:
				get_parent().min_three_count += 1
				get_parent().score += -3
				emit_signal("progress_bar_changed", -3)
			

func set_frame(value: int):
	$AnimatedSprite.frame = value


func _on_AnimatedSprite_frame_changed():
	$StationSound.play()
