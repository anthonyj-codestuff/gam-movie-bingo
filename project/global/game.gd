extends Node
var gameModeFiles = {
	"christian-classic": "res://assets/game-modes/christian-classic.json",
	"christian-classic-v2": "res://assets/game-modes/christian-classic-v2.json",
	"conspiracy": "res://assets/game-modes/conspiracy.json",
	"neil-breen": "res://assets/game-modes/neil-breen.json"
}

# NxN number of cells for grid
var gridSize: int = 0

# stores selected game configuration for easy access
var currentGameTitle: String = "Christian Movie Bingo"
var currentGameData: Array = []
var currentGameIgnoreRarity = true

# holds all squares that have ever been included in the current board
var currentBoard: Array = []

# if enabled, clicking on a square will remove it from the board
var pruneMode = false
var pruneModeDisabled = false
const unlimitedPrunes = false

# number of times the user is allowed to remove a square from the board
var defaultPrunes = 3
var prunesRemaining = 3

var currentScore = 0

func getGameSquareData() -> Array:
	if currentGameData.size():
		return currentGameData
	else:
		var defaultData = Utils.getJSONData(gameModeFiles["christian-classic"])
		currentGameIgnoreRarity = defaultData["ignoreRarity"]
		return defaultData.data

func resetBoard():
	gridSize = 0
	currentBoard = []
	pruneMode = false
	pruneModeDisabled = false
	prunesRemaining = defaultPrunes
	
func disablePruning():
	pruneMode = false
	pruneModeDisabled = true
