extends Label


# Called when the node enters the scene tree for the first time.
func _process(delta):
	text = "SCORE: " + str(Game.currentScore)
