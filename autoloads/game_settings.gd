extends Node

signal player1_hp
signal player1_score
signal player2_hp
signal player2_score
signal level

export var player1_hp = 100 setget player1_hp_emitter
export var player1_score = 0 setget player1_score_emitter
export var player2_hp = 100 setget player2_hp_emitter
export var player2_score = 0 setget player2_score_emitter
export var level = 1 setget level_emitter


func player1_hp_emitter(val):
	player1_hp = val
	emit_signal("player1_hp")

func player1_score_emitter(val):
	player1_score += val
	emit_signal("player1_score")

func player2_hp_emitter(val):
	player2_hp = val
	emit_signal("player2_hp")

func player2_score_emitter(val):
	player2_score += val
	emit_signal("player2_score")

func level_emitter(incr):
	level += incr
	emit_signal("level")
	

var flying_speed = 200
var ass_on_screen = 0
