extends TextureButton

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Game.pruneModeDisabled:
		disabled = true
	else:
		disabled = false
