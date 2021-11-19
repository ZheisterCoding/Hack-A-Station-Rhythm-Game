extends Node2D

const TARGET_Y = 192
const SPAWN_Y = 620
const DIST_TO_TARGET = abs(TARGET_Y - SPAWN_Y)

const LANE_ONE_SPAWN = Vector2(104, SPAWN_Y)
const LANE_TWO_SPAWN = Vector2(312, SPAWN_Y)
const LANE_THREE_SPAWN = Vector2(512, SPAWN_Y)
const LANE_FOUR_SPAWN = Vector2(712, SPAWN_Y)
const LANE_FIVE_SPAWN = Vector2(920, SPAWN_Y)

var speed = 0
var hit = false
var cart_type = ""

export(SpriteFrames) onready var plus_sprite_frame 
export(SpriteFrames) onready var min_one_sprite_frame
export(SpriteFrames) onready var min_three_sprite_frame

func _ready():
	pass


func _physics_process(delta):
	if !hit:
		position.y -= speed * delta
		if position.y < 120:
			queue_free()
#			get_parent().reset_combo()
	else:
		$Node2D.position.y -= speed * delta


func initialize(lane, type):
	cart_type = type
	match cart_type:
		"minus_one":
			$AnimatedSprite.frames = min_one_sprite_frame
		"minus_three":
			$AnimatedSprite.frames = min_three_sprite_frame
		"plus":
			$AnimatedSprite.frames = plus_sprite_frame
		_:
			printerr("Invalid type set for cart: " + str(cart_type))
			return
	match lane:
		0:
			position = LANE_ONE_SPAWN
		1:
			position = LANE_TWO_SPAWN
		2:
			position = LANE_THREE_SPAWN
		3:
			position = LANE_FOUR_SPAWN
		4:
			position = LANE_FIVE_SPAWN
		_:
			printerr("Invalid lane set for cart: " + str(lane))
			return
	speed = DIST_TO_TARGET / 2.0


func destroy():
	$Timer.start()


func _on_Timer_timeout():
	queue_free()
