extends TextureRect

func _ready():
	var texture = load(Game.currentGameHeader)
	self.set_texture(texture)
