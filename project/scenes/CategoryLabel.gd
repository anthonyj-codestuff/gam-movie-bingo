extends Label

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	text = "CATEGORY: " + Game.currentGameData.title
