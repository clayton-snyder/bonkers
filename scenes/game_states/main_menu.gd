extends Control

func _on_PlayButton_pressed():
	get_tree().change_scene("res://scenes/levels/sand.tscn")

func _on_ExitButton_pressed():
	self.get_tree().quit()
