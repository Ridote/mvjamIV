extends Node2D

var direction = Vector2(1,0)
var speed = 2000
var rot_speed = 20
var damage = 5

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _physics_process(delta):
	var collision = $KinematicBody2D.move_and_collide(direction*speed*delta)
	$KinematicBody2D.rotate(rot_speed*delta)
	if collision:
		if(collision.collider.get_parent().has_method("put_some_decent_panties_on_this_ass")):
			collision.collider.get_parent().put_some_decent_panties_on_this_ass(damage)

	if collision:
		queue_free()

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()