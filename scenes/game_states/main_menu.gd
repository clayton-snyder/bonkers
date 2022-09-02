extends Control

func _on_PlayButton_pressed():
	get_tree().change_scene("res://scenes/levels/sand.tscn")

func _on_ExitButton_pressed():
	self.get_tree().quit()

func _on_TutorialButton_pressed():
	get_tree().change_scene("res://scenes/game_states/Tutorial.tscn")
