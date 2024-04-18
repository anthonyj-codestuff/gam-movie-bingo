extends Node2D

var gridSize: int
var windowWidth: int
var windowHeight: int

# Called when the node enters the scene tree for the first time.
func _ready():
	gridSize = Game.gridSize
	windowWidth = int(get_viewport_rect().size.x)
	windowHeight = int(get_viewport_rect().size.y)

	# set position
	get_node("Grid/GridContainer").position = Vector2(Game.PADDINGL, Game.PADDINGT)
	
	# spawn child nodes
	for i in pow(gridSize, 2):
		var x = (windowWidth - Game.PADDINGR - Game.PADDINGL) / gridSize
		var y = (windowHeight - Game.PADDINGT - Game.PADDINGB) / gridSize
		print("Creating new child " + str(i))
		get_node("Grid/GridContainer").addNode(x, y, 30, str(i+1))
		

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
