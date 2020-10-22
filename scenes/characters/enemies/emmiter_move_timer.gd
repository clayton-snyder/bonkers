extends Timer

var wait_time_range : Vector2 = Vector2(3.0, 13.0)
var rng : RandomNumberGenerator

func _ready():
	rng = RandomNumberGenerator.new()
	rng.randomize()
	self.start(rng.randf_range(wait_time_range[0], wait_time_range[1]))
	print("started with " + str(self.get_wait_time()))

func _on_emmiter_move_timer_timeout():
	print("move_timer finised")
	self.start(rng.randf_range(wait_time_range[0], wait_time_range[1]))
	print("now " + str(self.get_wait_time()))
