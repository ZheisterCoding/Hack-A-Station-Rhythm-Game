extends Node2D

signal update_score_label(score)
signal set_capacity(_capacity)

onready var lane_three_is_opened = false 
onready var lane_four_is_opened = false
onready var lane_five_is_opened = false

onready var score = 0
onready var plus_count = 0
onready var min_one_count = 0
onready var min_three_count = 0
export var first_cut_capacity = 0
var capacity 

export var bpm = 115

var song_position = 0.0
var song_position_in_beats = 0
var last_spawned_beat = 0
var sec_per_beat = 60.0 / bpm

onready var spawn_1_beat = 0
onready var spawn_2_beat = 0
onready var spawn_3_beat = 2
onready var spawn_4_beat = 0

onready var lane = 0
onready var rand = 0
onready var rand_type = 0
onready var cart = load("res://scenes/Dynamic/Cart.tscn")
var cart_type
var instance


func _ready():
	randomize()
	_calculate_capacity()
	$Conductor.play_with_beat_offset(8)
	$Station3.set_frame(1)
	$Station4.set_frame(1)
	$Station5.set_frame(1)


func _process(delta):
	_check_score()
	_update_lane_states()
	emit_signal("update_score_label", score)
	
func _on_Conductor_measure(position):
	if position == 1:
		_spawn_notes(spawn_1_beat)
	elif position == 2:
		_spawn_notes(spawn_2_beat)
	elif position == 3:
		_spawn_notes(spawn_3_beat)
	elif position == 4:
		_spawn_notes(spawn_4_beat)

func _on_Conductor_beat(position):
	song_position_in_beats = position
	if song_position_in_beats > 36:
		spawn_1_beat = 1
		spawn_2_beat = 1
		spawn_3_beat = 1
		spawn_4_beat = 1
	if song_position_in_beats > 98:
		spawn_1_beat = 2
		spawn_2_beat = 0
		spawn_3_beat = 1
		spawn_4_beat = 0
	if song_position_in_beats > 132:
		spawn_1_beat = 0
		spawn_2_beat = 2
		spawn_3_beat = 0
		spawn_4_beat = 2
	if song_position_in_beats > 162:
		spawn_1_beat = 2
		spawn_2_beat = 2
		spawn_3_beat = 1
		spawn_4_beat = 1
	if song_position_in_beats > 194:
		spawn_1_beat = 2
		spawn_2_beat = 2
		spawn_3_beat = 1
		spawn_4_beat = 2
	if song_position_in_beats > 228:
		spawn_1_beat = 0
		spawn_2_beat = 2
		spawn_3_beat = 1
		spawn_4_beat = 2
	if song_position_in_beats > 258:
		spawn_1_beat = 1
		spawn_2_beat = 2
		spawn_3_beat = 1
		spawn_4_beat = 2
	if song_position_in_beats > 288:
		spawn_1_beat = 0
		spawn_2_beat = 2
		spawn_3_beat = 0
		spawn_4_beat = 2
	if song_position_in_beats > 322:
		spawn_1_beat = 3
		spawn_2_beat = 2
		spawn_3_beat = 2
		spawn_4_beat = 1
	if song_position_in_beats > 388:
		spawn_1_beat = 1
		spawn_2_beat = 0
		spawn_3_beat = 0
		spawn_4_beat = 0
	if song_position_in_beats > 396:
		spawn_1_beat = 0
		spawn_2_beat = 0
		spawn_3_beat = 0
		spawn_4_beat = 0
	if song_position_in_beats > 404:
		Global.score = score
		Global.progress_capacity = capacity
		Global.min_one_count = min_one_count
		Global.min_three_count = min_three_count
		Global.plus_count = plus_count
		if lane_five_is_opened:
			Global.level_passed = true
		else:
			Global.level_passed = false
		if get_tree().change_scene("res://scenes/UI/EndScreen.tscn") != OK:
			print ("Error changing scene to End")



func _spawn_notes(to_spawn):
	if to_spawn > 0:
		rand = _randomize_lane()
		lane = rand
		instance = cart.instance()
		instance.initialize(lane, _randomize_type())
		add_child(instance)
	if to_spawn > 1:
		while rand == lane:
			rand = _randomize_lane()
		lane = rand
		instance = cart.instance()
		instance.initialize(lane, _randomize_type())
		add_child(instance)
		

func _update_lane_states():
	if score >= first_cut_capacity:
		lane_three_is_opened = true
		$Station3.set_frame(0)
	else:
		lane_three_is_opened = false
		$Station3.set_frame(1)
		
	if score >= 2 * first_cut_capacity:
		lane_four_is_opened = true
		$Station4.set_frame(0)
	else:
		lane_four_is_opened = false
		$Station4.set_frame(1)
		
	if score >= 3 * first_cut_capacity:
		lane_five_is_opened = true
		$Station5.set_frame(0)
	else:
		lane_five_is_opened = false
		$Station5.set_frame(1)
		
	
func _randomize_lane() -> int:
	var divisor = 2
	
	if lane_three_is_opened:
		divisor = 3
		
	if lane_four_is_opened:
		divisor = 4
		
	if lane_five_is_opened:
		divisor = 5

	return randi() % divisor

func _randomize_type() -> String:
	rand_type = randi() % 4
	if rand_type > 1:
		return "minus_one"
	elif rand_type == 1:
		return "minus_three"
	elif rand_type == 0:
		return "plus"
		
	return ""

func _check_score():
	if score < 0:
		score = 0
	if score > capacity:
		score = capacity

func _calculate_capacity():
	capacity = first_cut_capacity * 4
	emit_signal("set_capacity", capacity)


