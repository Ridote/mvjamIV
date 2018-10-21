extends Node2D
var poopFactoryJAJA = load("res://entities/projectiles/Shit.tscn")
var speed = 2000
var falling_speed = 200

var HP = 200
var dead = false

var points = 5

var max_rand_time = 10
var min_rand_time = 4
var goUp = false

func _ready():
	$IsPoopTime.wait_time = abs(randf()*(max_rand_time+1+min_rand_time) - min_rand_time)+0.1
	$IsPoopTime.start()
	game_settings.ass_on_screen += 1
	
func _physics_process(delta):
	if !dead:
		if $KinematicBody2D.global_position.y - 20 <= -660:
			goUp = false
		elif $KinematicBody2D.global_position.y + 20 >= 660:
			goUp = true
			print($KinematicBody2D.global_position.y)
		if goUp:
			$KinematicBody2D.move_and_collide(Vector2(1,-1)*game_settings.flying_speed*delta)
		else:
			$KinematicBody2D.move_and_collide(Vector2(1,1)*game_settings.flying_speed*delta)
		return
	$IsPoopTime.stop()
	$KinematicBody2D.move_and_slide(Vector2(0,1)*falling_speed, Vector2(0,1))
func bread_this_ass(dmg = 1, player = 0):
	if dead:
		game_settings.player1_score += 5
		return
	HP -= dmg
	if HP <= 0:
		$AnimationPlayer.play("Bread")
		dead = true
		game_settings.ass_on_screen -= 1
		$KinematicBody2D.collision_mask = 0
		$KinematicBody2D.layers = 0
		if player == 0:
			game_settings.player1_score += points
		else:
			game_settings.player1_score += points
			
	
func put_some_decent_panties_on_this_ass(dmg = 1, player = 0):
	if dead:
		game_settings.player1_score += 5
		return
	HP -= dmg
	if HP <= 0:
		$AnimationPlayer.play("Panty")
		dead = true
		game_settings.ass_on_screen -= 1
		$KinematicBody2D.collision_mask = 0
		$KinematicBody2D.layers = 0
	
func _on_VisibilityNotifier2D_screen_exited():
	queue_free()


func _on_IsPoopTime_timeout():
	var poop = poopFactoryJAJA.instance()
	get_tree().get_root().add_child(poop)
	poop.global_position = $KinematicBody2D.global_position - Vector2(50, 0)
	
	$IsPoopTime.wait_time = abs(randf()*(max_rand_time+1+min_rand_time) - min_rand_time)+0.1
	$IsPoopTime.start()
