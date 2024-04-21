extends GridContainer
var BingoSquare = preload("res://global/BingoSquare.tscn")

var gridSize: int = Game.gridSize
var boardWidth: int
var boardHeight: int

# Called when the node enters the scene tree for the first time.
func _ready():
	# set board parameters
	columns = gridSize
	boardWidth = size.x
	boardHeight = size.y
	
	# spawn child nodes
	var cellWidth = boardWidth / gridSize
	var cellHeight = boardHeight / gridSize
	for i in pow(gridSize, 2):
		print("Creating new child " + str(i))
		addNode(cellWidth, cellHeight, 30, str(i+1))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func addNode(width:int, height:int, fontSize:int, text:String, image:Texture2D = load("res://assets/blank.png")):
	var square = BingoSquare.instantiate()
	square.setState(width, height, fontSize, text, image)
	add_child(square)


func _on_back_pressed():
	get_tree().change_scene_to_file("res://menu.tscn")
