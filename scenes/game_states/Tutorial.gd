extends Control

func _on_PlayButton_pressed():
	get_tree().change_scene("res://scenes/levels/sand.tscn")


func _on_MainMenuButton_pressed():
	get_tree().change_scene("res://scenes/game_states/main_menu.tscn")
