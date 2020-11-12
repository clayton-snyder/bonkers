extends Area2D

export var grav : float = 35.0
export var duration : float = 50.0

func _ready():
	self.set_collision_layer_bit(0, false)
	self.set_collision_layer_bit(5, true)
	$Timer.start(duration)

func _process(delta):
	var bonkers_orbiting : Array = self.get_overlapping_bodies();
	var close_bonkers : int = 0
	for bonker in bonkers_orbiting:
#		print (bonker.get_name())
		var dist : float = self.get_global_position().distance_to(bonker.get_global_position())
		var radius = $CollisionShape2D.shape.get_radius()
		if dist < (radius / 2):
			close_bonkers += 1
		var closeness : float = (radius - dist) / radius
		if closeness < 0:
			closeness = 0
		var dir_to_me : Vector2 = bonker.get_global_position().direction_to(self.get_global_position()).normalized()
		var bonker_dir : Vector2 = bonker.dir_vec.normalized()
		var weight : float = closeness * grav * delta
		var bonker_new_dir : Vector2 = (dir_to_me * weight) + (bonker_dir * (1 - weight))
		bonker.dir_vec = bonker_new_dir.normalized()
	set_extra_scale(0.1 * close_bonkers)

func set_extra_scale(extra_scale : float):
	$Sprite.scale = Vector2(1.0 + extra_scale, 1.0 + extra_scale)
	$CollisionShape2D.scale = Vector2(1.0 + extra_scale, 1.0 + extra_scale)

func _on_Timer_timeout():
	self.queue_free()
