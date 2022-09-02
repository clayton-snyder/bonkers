extends Control

func _ready():
	$score_msg.text = "You destroyed %s emitters.\n" % Global.score
	if Global.score > Global.hiscore:
		Global.hiscore = Global.score
		$score_msg.text += "That's a new hiscore!"
	else:
		$score_msg.text += "Your hiscore is %s." % Global.hiscore
	
func _process(debug):
	if Input.is_action_pressed("ui_select"):
		Global.score = 0
		get_tree().change_scene("res://scenes/levels/sand.tscn")
	if Input.is_action_pressed("ui_cancel"):
		get_tree().quit()


func _on_PlayAgainButton_pressed():
	Global.score = 0
	get_tree().change_scene("res://scenes/levels/sand.tscn")



func _on_ExitButton_pressed():
	get_tree().quit()


func _on_MainMenuButton_pressed():
	get_tree().change_scene("res://scenes/game_states/main_menu.tscn")
