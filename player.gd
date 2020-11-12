extends KinematicBody2D

export var move_speed : float = 200.0
export var max_health : int = 3
var curr_health : int
var shield_on : bool
export var shield_charge_max : float = 100.0
var shield_charge_curr : float
export var shield_use_rate : float = 20.0
export var shield_charge_rate : float = 50.0
var shield_locked
var grav_field_locked
export var grav_cd_secs : float = 10.0

var shield_new_activate : bool
const BonkerScene = preload('res://scenes/objects/bonker.tscn')
const GravFieldScene = preload('res://scenes/objects/grav_field.tscn')

func _ready():
	curr_health = max_health
	shield_on = false
	shield_charge_curr = shield_charge_max
	shield_new_activate = true
	grav_field_locked = false

func _process(delta):
	if Input.is_action_pressed('player_shield'):
		if shield_new_activate:
			if shield_charge_curr >= 10:
				shield_charge_curr -= 10
				shield_new_activate = false
			else:
				return
		shield_charge_curr -= shield_use_rate * delta
		if shield_charge_curr <= 0:
			set_shield_on(false)
		else:
			set_shield_on(true)
	else:
		set_shield_on(false)
		if shield_charge_curr > shield_charge_max:
			shield_charge_curr = shield_charge_max
		else:
			shield_charge_curr += shield_charge_rate * delta
	$shield/shield_charge_bar.value = shield_charge_curr

	if Input.is_action_just_pressed('player_shoot'):
		var new_bonker = BonkerScene.instance()
		new_bonker.dir_vec = self.get_global_position().direction_to(get_global_mouse_position()).normalized()
		new_bonker.position = self.get_global_position()
		new_bonker.is_bullet = true
		get_tree().get_root().get_node('root').add_child(new_bonker)

	if Input.is_action_just_pressed('player_alt_shoot'):
		if not grav_field_locked:
			var new_grav_field = GravFieldScene.instance()
			new_grav_field.position = get_global_mouse_position() # need to bound check
			get_tree().get_root().get_node('root').add_child_below_node(get_node('../TileMap'), new_grav_field)
			grav_field_locked = true
			$grav_cd_timer.start(grav_cd_secs)
		else:
			# play sound
			pass

func _physics_process(delta):
	var coll : KinematicCollision2D
	if Input.is_action_pressed('player_move_up'):
		coll = self.move_and_collide(Vector2.UP * move_speed * delta)
	if Input.is_action_pressed('player_move_down'):
		coll = self.move_and_collide(Vector2.DOWN * move_speed * delta)
	if Input.is_action_pressed('player_move_left'):
		coll = self.move_and_collide(Vector2.LEFT * move_speed * delta)
	if Input.is_action_pressed('player_move_right'):
		coll = self.move_and_collide(Vector2.RIGHT * move_speed * delta)


func take_damage(var damage_taken : int):
	print('player taking damage')
	curr_health -= damage_taken
	$player_sprite.show_percent(float(curr_health) / max_health)
	if curr_health <= 0:
		get_tree().change_scene('res://scenes/game_states/end_screen.tscn')
		for child in get_tree().get_root().get_node('root').get_children():
			if child.get_class() == 'bonker':
				child.queue_free()

func set_shield_on(shield_on : bool):
	if shield_on:
		shield_on = true
		$shield/Sprite.show()
		$shield/shield_collide_shape.disabled = false
	else:
		shield_on = false
		$shield/Sprite.hide()
		$shield/shield_collide_shape.disabled = true
		shield_new_activate = true # slighly misleading; is for next time user presses shield

func lock_shield():
		shield_locked = true
		shield_on = false
		$shield/Sprite.hide()
		$shield/shield_collide_shape.disabled = true
		$shield/shield_lock_timer.start(1)
		$shield/shield_charge_bar.tint_progress = Color(1, 0, 0)


func get_class():
	return 'player'


func _on_player_hitbox_body_entered(body : Node2D):
	if body.get_class() == 'bonker' and not body.is_bullet:
		if not shield_on:
			take_damage(1)
		body.queue_free()


func _on_shield_body_entered(body):
	if body.get_class() == 'bonker' and not body.is_bullet:
		body.queue_free()


func _on_grav_cd_timer_timeout():
	grav_field_locked = false
