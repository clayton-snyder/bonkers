extends Node

var score : int

enum EntityType { ENEMY, PLAYER, TERRAIN }

func _ready():
	score = 0
