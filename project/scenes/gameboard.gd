extends GridContainer

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
	var length = gameCells.size()
	# double-check that we don't need to clear this
	Game.currentBoard = []
	if length and length >= pow(gridSize, 2):
		for i in pow(gridSize, 2):
			var randInt = randi_range(0, length-1)
			while Game.currentBoard.has(randInt):
				randInt = randi_range(0, length-1)
			var cell = gameCells[randInt]
			Game.currentBoard.push_back(randInt)
			var newCell = Utils.getNewBingoSquareFromData(randInt)
			add_child(newCell)
	else:
		print("Error: No game cells found")
		print("gameCells: ", length)
		print("gridSize: ", gridSize)

func _process(delta):
	var total = 0
	for i in get_children():
		if i.get_node("Tick").visible:
			total += i.getPointValue()
	Game.currentScore = total

func _on_back_pressed():
	Game.resetBoard()
	get_tree().change_scene_to_file("res://scenes/menu.tscn")
