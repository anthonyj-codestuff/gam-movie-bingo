extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	var gridSize = Game.gridSize


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	get_node("Label").text = str(get_viewport_rect().size)
	pass
