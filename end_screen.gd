extends Node2D

func _ready():
	$score_msg.text = 'SCORE: ' + str(Global.score)
	
func _process(debug):
	if Input.is_action_pressed("ui_select"):
		Global.score = 0
		get_tree().change_scene("res://scenes/levels/sand.tscn")
	if Input.is_action_pressed("ui_cancel"):
		get_tree().quit()
