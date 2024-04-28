extends GridContainer
var BingoSquare = preload("res://global/BingoSquare.tscn")

var gridSize: int = Game.gridSize
var boardWidth: int
var boardHeight: int

func _ready():
	# set board parameters
	columns = gridSize
	boardWidth = size.x
	boardHeight = size.y
	
	# spawn child nodes
	var gameCells = Game.getGameSquareData()
	var length = len(gameCells)
	# double-check that we don't need to clear this
	Game.currentBoard = []
	for i in pow(gridSize, 2):
		var randInt = randi_range(0, length-1)
		while Game.currentBoard.has(randInt):
			randInt = randi_range(0, length-1)
		var cell = gameCells[randInt]
		Game.currentBoard.push_back(randInt)
		addNode(30, "", cell.rarity, cell.filename)

func _process(delta):
	var total = 0
	for i in get_children():
		if i.get_node("Tick").visible:
			total += i.getPointValue()
	Game.currentScore = total

func addNode(fontSize:int, text:String, score:int=0, image:String="res://assets/blank.png"):
	var square = BingoSquare.instantiate()
	var texture = load(image)
	square.setState(fontSize, text, score, texture)
	add_child(square)


func _on_back_pressed():
	Game.resetBoard()
	get_tree().change_scene_to_file("res://menu.tscn")
