extends TextureButton

var knifeNormal = load("res://assets/images/button_knife.png")
var knifeHover = load("res://assets/images/button_knife_hover.png")
var knifeToggled = load("res://assets/images/button_knife_toggled.png")
var knifeDisabled = load("res://assets/images/button_knife_disabled.png")
var iconChild:Node
var marginChild:Node

func setTextureSibling(node:Node):
	iconChild = node
	
func _ready():
	marginChild = $"../StrikesBox/LabelMargin"

func _process(delta):
	if Game.pruneModeDisabled:
		disabled = true
		iconChild.set_texture(knifeDisabled)
		marginChild.add_theme_constant_override("margin_top", 0)
	else:
		disabled = false

func _on_toggled(buttonPressed):
	if buttonPressed:
		Game.pruneMode = true
		iconChild.set_texture(knifeToggled)
		marginChild.add_theme_constant_override("margin_top", 4)
	else:
		Game.pruneMode = false
		iconChild.set_texture(knifeNormal)
		marginChild.add_theme_constant_override("margin_top", 0)

func _on_mouse_entered():
	if not disabled and not Game.pruneMode:
		iconChild.set_texture(knifeHover)
	elif not disabled:
		iconChild.set_texture(knifeToggled)

func _on_mouse_exited():
	if not disabled and not Game.pruneMode:
		iconChild.set_texture(knifeNormal)
	elif Game.pruneMode:
		iconChild.set_texture(knifeToggled)
		
