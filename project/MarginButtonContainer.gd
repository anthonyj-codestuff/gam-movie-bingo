extends MarginContainer

func _ready():
	var knifeTexture = get_node("StrikesBox/KnifeIcon")
	var button = get_node("RedButton")
	button.setTextureSibling(knifeTexture)
