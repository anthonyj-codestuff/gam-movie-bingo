extends Label

func _process(delta):
	if Game.pruneMode or Game.pruneModeDisabled:
		text = ""
