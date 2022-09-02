extends Node

const SCN_EMITTER : PackedScene = preload("res://scenes/characters/enemies/emitter.tscn")

export var min_spawn_interval : float = 1.0
export var step_down : float = 0.3
export var curr_spawn_interval : float = 5.0

var rng : RandomNumberGenerator

# Called when the node enters the scene tree for the first time.
func _ready():
	$EmitterSpawner.start(curr_spawn_interval)
	curr_spawn_interval = max(min_spawn_interval, curr_spawn_interval - step_down)
	rng = RandomNumberGenerator.new()
	rng.randomize()


func _on_EmitterSpawner_timeout():
	$EmitterSpawner.start(curr_spawn_interval)
	curr_spawn_interval = max(min_spawn_interval, curr_spawn_interval - step_down)
	var new_emitter : KinematicBody2D = SCN_EMITTER.instance()
	var spawn_locations : Array = $SpawnLocations.get_children()
	var location : Position2D = spawn_locations[rng.randi_range(0, len(spawn_locations) - 1)]
	new_emitter.global_position = location.global_position
	get_tree().current_scene.add_child_below_node($SpawnLocations, new_emitter)
