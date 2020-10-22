extends KinematicBody2D

const BonkerScene = preload('res://scenes/objects/bonker.tscn')

var rng : RandomNumberGenerator
var move_dir : Vector2
export var move_speed : float = 50.0
export var health : int = 1

func _ready():
	rng = RandomNumberGenerator.new()
	rng.randomize()
	move_dir = Vector2(rng.randf_range(-1.0, 1.0), rng.randf_range(-1.0, 1.0)).normalized()

func _physics_process(delta):
	var coll : KinematicCollision2D = self.move_and_collide(move_dir * move_speed * delta)
	if coll:
		change_dir()

func _on_spawn_timer_timeout():
	var new_bonker = BonkerScene.instance()
	new_bonker.dir_vec = Vector2(rng.randf_range(-1.0, 1.0), rng.randf_range(-1.0, 1.0)).normalized()
	new_bonker.position = self.get_global_position()
	self.get_tree().get_root().get_node('root').add_child(new_bonker)

func get_class():
	return "enemy"
	
func take_damage(var damage_taken : int):
	health -= damage_taken
	if health <= 0:
		self.queue_free()
		Global.score += 1
		
func change_dir():
	move_dir = Vector2(rng.randf_range(-1.0, 1.0), rng.randf_range(-1.0, 1.0)).normalized()


func _on_emmiter_move_timer_timeout():
	change_dir()
