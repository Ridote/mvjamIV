extends Node2D

var map = load("res://entities/Maps/Map1.tscn")
var playerBunnyFactory = load("res://entities/Players/Bunny/PlayerBunny.tscn")
var playerCatFactory = ""

func start_game():
	$MainMenu.queue_free()
	var bunny = playerBunnyFactory.instance()
	$Camera2D.current = true
	bunny.position += Vector2(150,150)
	
	get_tree().get_root().add_child(map.instance())
	get_tree().get_root().add_child(bunny)
	
	