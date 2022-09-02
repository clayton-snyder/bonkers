extends Area2D

export var grav : float = 450.0


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _process(delta):
	var affected_bodies = self.get_overlapping_bodies()
	for body in affected_bodies:
		var dist : float = self.get_global_position().distance_to(body.get_global_position())
		var radius = $CollisionShape2D.shape.get_radius()
#		if dist < (get_close_orbit_dist()):
#			close_bonkers += 1
		var closeness : float = (radius - dist) / radius
		if closeness < 0:
			closeness = 0
		var dir_to_me : Vector2 = body.get_global_position().direction_to(self.get_global_position()).normalized()
#		var body_dir : Vector2 = body.dir_vec.normalized()
		var weight : float = closeness * grav * delta
		body.move_and_collide(dir_to_me * weight)
#		var bonker_new_dir : Vector2 = (dir_to_me * weight) + (bonker_dir * (1 - weight))
#		bonker.dir_vec = bonker_new_dir.normalized()
