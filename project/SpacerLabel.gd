extends Label

func _ready():
	text = "You may strike up to " + str(Game.prunesRemaining) + " tiles"

func _process(delta):
	if Game.pruneMode or Game.pruneModeDisabled:
		text = ""
