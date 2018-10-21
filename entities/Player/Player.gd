extends Node2D

var baguetteFactory = load("res://entities/projectiles/Baguette.tscn")
var pantyFactory = load("res://entities/projectiles/Panty.tscn")
var bulletsFactory = null
var bunnyShip = load("res://.import/bunnyship.png-3a2c217364b14e3684839002c06526cf.stex")
var catShip = load("res://.import/catship.png-8297108db0836cd6fae645747cfa57c3.stex")

export var speed = 1000

var player = 0
var mask_save = 0
var layer_save = 0


var move_up = false
var move_down = false
var move_right = false
var move_left = false
var fire = false

var fire_rate = 0.4
var bullet_power = 0.5
var fire_ready = true

#Top, Down, Right, Left
var forceStop = [false, false, false, false]
var needsImpulse = false

func _ready():
	$rigid.apply_impulse(Vector2(0.0,0.0),Vector2(1.0,0.0))
	$rigid.rotation = PI/2

func setCat():
	$rigid/Particles2D.process_material.color = Color(1,0.5,0,1)
	bulletsFactory = baguetteFactory
	$rigid/Sprite.set_texture(catShip)
	fire_rate = 0.4
	bullet_power = 1.5
func setBunny():
	$rigid/Particles2D.process_material.color = Color(1,0,1,1)
	bulletsFactory = pantyFactory
	$rigid/Sprite.set_texture(bunnyShip)
	fire_rate = 0.1
	bullet_power = 0.4
	
func shoot():
	if fire_ready:
		fire_ready = false
		$fire_rate.wait_time = fire_rate
		$fire_rate.start()
		var bullet = bulletsFactory.instance()
		get_tree().get_root().add_child(bullet) #must be here to avoid wrong warning messages
		bullet.global_position = $rigid.global_position
		bullet.global_position.x += 100
	
	
func _process(delta):
	read_input()
	if fire:
		shoot()
	#Delete this
	if Input.is_action_pressed("ui_select"):
		setBunny()
		
	
func _physics_process(delta):
	move(delta)
	for collision in $rigid.get_colliding_bodies():
		if(collision.get_parent().get_name().substr(0,3) == "Ass" || collision.get_parent().get_name().substr(1,4) == "Shit"):
			print(collision.get_parent().get_name())
			if player == 0:
				game_settings.player1_hp -= collision.get_parent().getDamage()
			if player == 1:
				game_settings.player2_hp -= collision.get_parent().getDamage()
			layer_save = $rigid.collision_layer
			mask_save = $rigid.collision_mask
			$rigid.collision_layer = 0
			$rigid.collision_mask = 0
			$AnimationPlayer.play("damaged")
			$Damaged.start()
		
func read_input():
	move_right = Input.is_action_pressed("ui_right")
	move_left = Input.is_action_pressed("ui_left")
	move_up = Input.is_action_pressed("ui_up")
	move_down = Input.is_action_pressed("ui_down")
	fire = Input.is_action_pressed("ui_fire")
func move(delta):
	var direction = Vector2(0.0,0.0)
	if move_right:
		direction.x = 1.0
	if move_left:
		direction.x = -1.0
	if move_up:
		direction.y = -1.0
	if move_down:
		direction.y = 1.0
	
	#If we are going out of the screen...
	if forceStop[0] && $rigid.linear_velocity.y < 0:
		direction.y = 0
		$rigid.linear_velocity.y = 0.1
	if forceStop[1] && $rigid.linear_velocity.y > 0:
		direction.y = 0
		$rigid.linear_velocity.y = -0.1
	if forceStop[2] && $rigid.linear_velocity.x > 0:
		direction.x = 0
		$rigid.linear_velocity.x = -0.1
	if forceStop[3] && $rigid.linear_velocity.x < 0:
		direction.x = 0
		$rigid.linear_velocity.x = 0.1
		
	$rigid.apply_impulse(Vector2(0.0,0.0),direction*speed*delta)
	
	#We will always add the global speed of the scene if we don't have it already
	if $rigid.linear_velocity.x < game_settings.flying_speed:
		$rigid.apply_impulse(Vector2(0.0,0.0),Vector2(1.0,0.0)*game_settings.flying_speed*delta)
	
	if needsImpulse:
		$rigid.apply_impulse(Vector2(0.0,0.0),Vector2(1.0,0.0)*game_settings.flying_speed*delta*10)
	
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
	needsImpulse = false
func _on_VisibilityLeft_screen_exited():
	#Top, Down, Right, Left
	forceStop[3] = true
	needsImpulse = true

func _on_Damaged_timeout():
	$rigid.collision_layer = layer_save
	$rigid.collision_mask = mask_save
	$AnimationPlayer.play("notDamaged")
