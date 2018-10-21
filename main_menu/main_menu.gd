extends CanvasLayer



func _on_Single_Player_pressed():
	get_parent().start_game()


func _on_Multiplayer_LAN_pressed():
	get_parent().start_game()
