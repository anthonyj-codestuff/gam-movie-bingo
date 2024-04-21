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
	var gameCells = Game.currentGame.data
	var length = len(gameCells)
	var pickedCells: Array = []
	for i in pow(gridSize, 2):
		var randInt = randi_range(0, length-1)
		while pickedCells.has(randInt):
			randInt = randi_range(0, length-1)
		var cell = gameCells[randInt]
		pickedCells.push_back(randInt)
		addNode(cellWidth, cellHeight, 30, "", cell.filename)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func addNode(width:int, height:int, fontSize:int, text:String, image:String = "res://assets/blank.png"):
	var square = BingoSquare.instantiate()
	var texture = load(image)
	square.setState(width, height, fontSize, text, texture)
	add_child(square)


func _on_back_pressed():
	get_tree().change_scene_to_file("res://menu.tscn")
