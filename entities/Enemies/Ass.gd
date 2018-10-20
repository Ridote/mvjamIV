extends Node2D
var poopFactoryJAJA = load("res://entities/projectiles/Shit.tscn")
var speed = 2000
var HP = 200
var dead = false

var max_rand_time = 10
var min_rand_time = 4

func _ready():
	$IsPoopTime.wait_time = randf()*(max_rand_time+1+min_rand_time) - min_rand_time
	$IsPoopTime.start()
	
func _physics_process(delta):
	if !dead:
		var collision = $KinematicBody2D.move_and_collide(Vector2(1,0)*game_settings.flying_speed*delta)
		return
	$IsPoopTime.stop()
func bread_this_ass(dmg = 1):
	if dead:
		return
	HP -= dmg
	if HP <= 0:
		$AnimationPlayer.play("Bread")
		dead = true
	
func put_some_decent_panties_on_this_ass(dmg = 1):
	if dead:
		return
	HP -= dmg
	if HP <= 0:
		$AnimationPlayer.play("Panty")
		dead = true
		$KinematicBody2D.collision_mask = 0
		$KinematicBody2D.layers = 0
	
func _on_VisibilityNotifier2D_screen_exited():
	queue_free()


func _on_IsPoopTime_timeout():
	var poop = poopFactoryJAJA.instance()
	get_tree().get_root().add_child(poop)
	poop.global_position = $KinematicBody2D.global_position - Vector2(50, 0)
	
	$IsPoopTime.wait_time = randf()*(max_rand_time+1+min_rand_time) - min_rand_time
	$IsPoopTime.start()
