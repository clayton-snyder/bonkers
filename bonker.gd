extends KinematicBody2D

export var bullet_speed : float = 500.0
export var bonker_speed : float = 120.0
export var curr_speed : float = 120.0
export var dir_vec : Vector2
var velocity : Vector2
var is_bullet : bool = false

func _ready():
	if is_bullet:
		curr_speed = bullet_speed
		$Sprite.self_modulate = Color(0, 1, 0)
		set_damage_enemies(true)

func _physics_process(delta):
	# Direction times speed (scalar) to increase magnitude, scaled back by delta
	velocity = dir_vec * curr_speed * delta
	var coll : KinematicCollision2D = self.move_and_collide(velocity)
	if coll:
		if is_bullet:
			# If hit an enemy, damage enemy and remove this bullet
			if coll.collider.get_class().to_upper() == "enemy".to_upper():
				coll.collider.take_damage(1)
				self.queue_free()
				return
			is_bullet = false
			curr_speed = bonker_speed
			$Sprite.self_modulate = Color(1, 1, 1)
			# Now that not a bullet, shouldn't collide with/damage enemies
			set_damage_enemies(false)
		# Bounce the direction only; we want to maintain speed
		dir_vec = dir_vec.bounce(coll.normal).normalized()
		# re-calc velocity
		velocity = dir_vec * curr_speed * delta
		# immediately change direction
		self.move_and_collide(velocity)

func get_class():
	return 'bonker'
	
func set_damage_enemies(damage_enemies : bool):
	self.set_collision_mask_bit(3, damage_enemies)

