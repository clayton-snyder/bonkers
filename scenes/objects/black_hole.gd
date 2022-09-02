extends Area2D

func _process(delta):
	var byes : Array = self.get_overlapping_bodies();
	for bye in byes:
		if bye.get_name() == 'player':
			self.get_tree().change_scene("res://scenes/game_states/end_screen.tscn")
		bye.queue_free()


func _on_Timer_timeout():
	self.queue_free()
