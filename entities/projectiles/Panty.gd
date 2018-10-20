extends Node2D

var direction = Vector2(1,0)
var speed = 20
var rot_speed = 0.2

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _physics_process(delta):
	var collision = $KinematicBody2D.move_and_collide(direction*speed*delta)
	$KinematicBody2D.rotate(rot_speed)
