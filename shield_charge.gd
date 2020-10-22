extends TextureProgress

func _ready():
	self.rect_position = Vector2.ZERO - (self.texture_under.get_size() / 2)
	self.tint_over = Color(0, 0, 0)
	self.tint_progress = Color(0, 1, 0)
