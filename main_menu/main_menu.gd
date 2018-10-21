extends CanvasLayer



func _on_Single_Player_pressed():
	#$"PanelContainer/NinePatchRect/VBoxContainer/MarginContainer2/VBoxContainer/Single Player"
	get_parent().start_game()


func _on_Multiplayer_LAN_pressed():
	get_parent().start_game()
