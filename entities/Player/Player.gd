extends Node2D

var baguetteFactory = load("res://entities/projectiles/Baguette.tscn")
var pantyFactory = load("res://entities/projectiles/Panty.tscn")

export var speed = 20

var move_up = false
var move_down = false
var move_right = false
var move_left = false
var fire = false

var fire_ready = true

#Top, Down, Right, Left
var forceStop = [false, false, false, false]

func _ready():
	$rigid.apply_impulse(Vector2(0.0,0.0),Vector2(1.0,0.0))
	$rigid.rotation = PI/2

func _process(delta):
	read_input()
	if fire_ready && fire:
		fire_ready = false
		$fire_rate.start()
	
func _physics_process(delta):
	move()
		
func read_input():
	move_right = Input.is_action_pressed("ui_right")
	move_left = Input.is_action_pressed("ui_left")
	move_up = Input.is_action_pressed("ui_up")
	move_down = Input.is_action_pressed("ui_down")
	fire = Input.is_action_pressed("ui_fire")
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
	
	if forceStop[0] && $rigid.linear_velocity.y < 0:
		$rigid.linear_velocity.y = 1
	if forceStop[1] && $rigid.linear_velocity.y > 0:
		$rigid.linear_velocity.y = -1
	if forceStop[2] && $rigid.linear_velocity.x > 0:
		$rigid.linear_velocity.x = -1
	if forceStop[3] && $rigid.linear_velocity.x < 0:
		$rigid.linear_velocity.x = 1
	
	#var realDir = $rigid.linear_velocity.normalized()
	#$rigid.look_at($rigid.global_position + realDir)
	#$rigid.rotation += PI/2
	


func _on_fire_rate_timeout():
	fire_ready = true

func _on_VisibilityTop_screen_entered():
	#Top, Down, Right, Left
	forceStop[0] = false
func _on_VisibilityTop_screen_exited():
	#Top, Down, Right, Left
	forceStop[0] = true
func _on_VisibilityBottom_screen_entered():
	#Top, Down, Right, Left
	forceStop[1] = false
func _on_VisibilityBottom_screen_exited():
	#Top, Down, Right, Left
	forceStop[1] = true
func _on_VisibilityRight_screen_entered():
	#Top, Down, Right, Left
	forceStop[2] = false
func _on_VisibilityRight_screen_exited():
	#Top, Down, Right, Left
	forceStop[2] = true
func _on_VisibilityLeft_screen_entered():
	#Top, Down, Right, Left
	forceStop[3] = false
func _on_VisibilityLeft_screen_exited():
	#Top, Down, Right, Left
	forceStop[3] = true