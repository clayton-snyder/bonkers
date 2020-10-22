extends Sprite

var size : Vector2

func _ready():
	size = self.texture.get_size()
	self.centered = false
	self.offset = Vector2.ZERO - (size / 2) # Vector math!
	print('at ready offset = ' + str(self.offset))
	self.region_enabled = true
	self.region_rect = Rect2(Vector2.ZERO, size) # (pos, size) i.e., show full sprite to start

# Shows the horizontal percent of the sprite from the left
func show_percent(percent : float):
	self.region_rect = Rect2(Vector2.ZERO, Vector2(size.x * percent, size.y))
