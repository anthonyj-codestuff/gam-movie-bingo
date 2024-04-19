extends GridContainer
var BingoSquare = preload("res://global/BingoSquare.tscn")

var gridSize: int = Game.gridSize
var windowWidth: int = int(DisplayServer.window_get_size().x)
var windowHeight: int = int(DisplayServer.window_get_size().y)

# Called when the node enters the scene tree for the first time.
func _ready():
	columns = gridSize

	# set position
	##position = Vector2(Game.PADDINGL, Game.PADDINGT+Game.HEADERH)
	position = Vector2(Game.PADDINGL, Game.PADDINGT)
	
	# spawn child nodes
	for i in pow(gridSize, 2):
		var x = (windowWidth - Game.PADDINGR - Game.PADDINGL) / gridSize
		var y = (windowHeight - Game.PADDINGT - Game.PADDINGB) / gridSize
		print("Creating new child " + str(i))
		addNode(x, y, 30, str(i+1))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func addNode(width:int, height:int, fontSize:int, text:String, image:Texture2D = load("res://assets/blank.png")):
	var square = BingoSquare.instantiate()
	square.setState(width, height, fontSize, text, image)
	add_child(square)
