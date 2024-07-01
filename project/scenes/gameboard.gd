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
			var newSquareIndex = getNewGameSquareIndex(gameCells)
			var cell = gameCells[newSquareIndex]
			Game.currentBoard.push_back(newSquareIndex)
			var newCell = Utils.getNewBingoSquareFromData(newSquareIndex)
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

func getNewGameSquareIndex(squares):
	if Game.currentGameIgnoreRarity:
		var newIndex = randi_range(0, squares.size()-1)
		while Game.currentBoard.has(newIndex):
			newIndex = randi_range(0, squares.size()-1)
		return newIndex
	# The current game uses rarities, pick a weighted random square
	var vcommon = 0.511
	var common = 0.27
	var uncommon =  0.125
	var rare = 0.063
	var vrare = 0.031
	# sort cells into rarities. Filter out cells that are already on the board/history
	var gameCellsByRarity = catCellsByRarity(squares)

	var rand_rarity = randf()
	var rarity
	if(rand_rarity <= vrare):
		rarity = 5
	elif(rand_rarity <= rare+vrare):
		rarity = 4
	elif(rand_rarity <= uncommon+rare+vrare):
		rarity = 3
	elif(rand_rarity <= common+uncommon+rare+vrare):
		rarity = 2
	else:
		rarity = 1

	# if the selected rarity has no entries, lower the rarity
	while not gameCellsByRarity[rarity].size() and rarity > 1:
		print_rich("[color=orange]No more cells of rarity %s[/color]" % rarity)
		rarity -= 1
	if not gameCellsByRarity[rarity].size():
		print_rich("[color=red]ERROR: No more cells of rarity %s, returning 1[/color]" % rarity)
		return 1
	var newIndex = randi_range(0, gameCellsByRarity[rarity].size()-1)
	return gameCellsByRarity[rarity][newIndex]["originalIndex"]

func catCellsByRarity(squares):
	# convert [{1, "a"}, {1, "b"} {2, "c"}]
	# to {
	#      "1": [{1, "a"}, {1, "b"}],
	#      "2": [{2, "c"}]
	#    }
	var dictRarity = {
		1: [],
		2: [],
		3: [],
		4: [],
		5: []
	}
	for index in squares.size():
		var item = squares[index]
		# filter out cells that already exist in the board history
		if not Game.currentBoard.has(index):
			item["originalIndex"] = index
			dictRarity[int(item["rarity"])].append(item)
	return dictRarity
