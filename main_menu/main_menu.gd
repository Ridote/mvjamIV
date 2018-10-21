extends CanvasLayer



func _on_Single_Player_pressed():
	$PanelContainer/NinePatchRect/VBoxContainer/MarginContainer2/VBoxContainer/SinglePlayer.disabled = true
	$PanelContainer/NinePatchRect/VBoxContainer/MarginContainer2/VBoxContainer/MultiplayerLAN .disabled = true
	$PanelContainer/NinePatchRect/VBoxContainer/MarginContainer2/VBoxContainer/PopupMenu.visible = true


func _on_Multiplayer_LAN_pressed():
	game_settings.players = "Multi"
	get_parent().start_game()


func _on_PopupMenu_index_pressed(index):
	game_settings.players = "Single"
	if index == 0:
		game_settings.player1IsCat = 0
		get_parent().start_game()
	else:
		game_settings.player1IsCat = 1
		get_parent().start_game()