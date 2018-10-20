extends Node2D

var speed = 2000

func _physics_process(delta):
	var collision = $KinematicBody2D.move_and_collide(Vector2(1,0)*game_settings.flying_speed*delta)
	
func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
