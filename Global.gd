extends Node

var score : int
var hiscore : int

enum EntityType { ENEMY, PLAYER, TERRAIN }

func _ready():
	score = 0
	hiscore = 0
