extends Node2D

export var speed = 2

var move_up = false
var move_down = false
var move_right = false
var move_left = false

func _ready():
	$rigid.apply_impulse(Vector2(0.0,0.0),Vector2(1.0,0.0))

func _process(delta):
	read_input()
	
func _physics_process(delta):
	move()
		
func read_input():
	move_right = Input.is_action_pressed("ui_right")
	move_left = Input.is_action_pressed("ui_left")
	move_up = Input.is_action_pressed("ui_up")
	move_down = Input.is_action_pressed("ui_down")

func move():
	var direction = Vector2(0.0,0.0)
	if move_right:
		direction.x = 1.0
	if move_left:
		direction.x = -1.0
	if move_up:
		direction.y = -1.0
	if move_down:
		direction.y = 1.0
	$rigid.apply_impulse(Vector2(0.0,0.0),direction*speed)
	var realDir = $rigid.linear_velocity.normalized()
	$rigid.look_at($rigid.position + realDir)
	$rigid.rotation += PI/2
	