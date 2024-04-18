extends GridContainer

var BingoSquare = preload("res://global/BingoSquare.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	columns = Game.gridSize


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func addNode(width:int, height:int, fontSize:int, text:String, image:Texture2D = load("res://assets/blank.png")):
	var square = BingoSquare.instantiate()
	square.setState(width, height, fontSize, text, image)
	add_child(square)
