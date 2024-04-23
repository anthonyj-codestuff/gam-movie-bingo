extends Node

var gameModes: Array = [
	"conspiracy"
]

# NxN number of cells for grid
var gridSize: int = 0

# stores selected game configuration for easy access
var currentGameData: Dictionary = {}

# holds all squares that have ever been included in the current board
var currentBoard: Array = []

# if enabled, clicking on a square will remove it from the board
var pruneMode = false
var pruneModeDisabled = false

func getGameSquareData() -> Array:
	if currentGameData.has("data"):
		return currentGameData.data
	else:
		return []

func resetBoard():
	gridSize = 0
	currentGameData = {}
	currentBoard = []
	pruneMode = false
	
func disablePruning():
	pruneMode = false
	pruneModeDisabled = true
