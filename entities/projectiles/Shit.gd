extends Node2D

#Cause poops have life as well
var life = 10
var speed = 200

func _ready():
	life = 10 * game_settings.level
	speed = 200 * game_settings.level
	
func _physics_process(delta):
	$KinematicBody2D.move_and_collide(Vector2(-1,0)*speed*delta)

func getDmg(dmg):
	life -= dmg
	if life <= 0:
		queue_free()