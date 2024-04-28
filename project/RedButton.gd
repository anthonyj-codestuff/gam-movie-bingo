extends TextureButton

var knifeNormal = load("res://assets/images/button_knife.png")
var knifeHover = load("res://assets/images/button_knife_hover.png")
var knifeToggled = load("res://assets/images/button_knife_toggled.png")
var knifeDisabled = load("res://assets/images/button_knife_disabled.png")
var child:Node

func setTextureSibling(node:Node):
	child = node

func _process(delta):
	if Game.pruneModeDisabled:
		disabled = true
		child.set_texture(knifeDisabled)
	else:
		disabled = false

func _on_toggled(buttonPressed):
	if buttonPressed:
		Game.pruneMode = true
		child.set_texture(knifeToggled)
	else:
		Game.pruneMode = false
		child.set_texture(knifeNormal)

func _on_mouse_entered():
	if not disabled and not Game.pruneMode:
		child.set_texture(knifeHover)
	elif not disabled:
		child.set_texture(knifeToggled)

func _on_mouse_exited():
	if not disabled and not Game.pruneMode:
		child.set_texture(knifeNormal)
	elif Game.pruneMode:
		child.set_texture(knifeToggled)
		
