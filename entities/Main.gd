extends Node2D

var map = load("res://entities/Maps/Map1.tscn")
var playerBunnyFactory = load("res://entities/Player/Player.tscn")
var playerCatFactory = ""

var game_started = false

func _physics_process(delta):
	if not game_started:
		return
	
	$FocusScene.position.x += 5*delta

func start_game():
	$MainMenu.queue_free()
	var bunny = playerBunnyFactory.instance()
	bunny.position += Vector2(150,150)
	
	get_tree().get_root().add_child(map.instance())
	get_tree().get_root().add_child(bunny)
	
	

func _on_FocusScene_body_exited(body):
	print(body.get_name())
