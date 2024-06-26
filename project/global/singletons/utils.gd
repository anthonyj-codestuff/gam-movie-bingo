extends Node
const MODULE_NAME = "Utils"
#var logger = LogWriter.new()
var BingoSquare = preload("res://scenes/BingoSquare.tscn")

const defaults = {
	"fontSize": {
		"3": 40,
		"4": 25,
		"5": 23,
		"6": 21
	},
	"text": "",
	"score": 0,
	"image": "res://assets/images/blank.png",
	"altText": ""
}

###################
# New Square Stuff

func getNewBingoSquareFromData(index: int, target = null):
	var data = Game.getGameSquareData()
	if data[index]:
		var squareData = data[index]
		var fontSize = _getFontSizeByContent(squareData)
		var text = _getTitleFromCellData(squareData)
		var score = _getScoreFromCellData(squareData)
		var texture = load(_getImagepathFromCellData(squareData))
		var altText = _getAltTextFromCellData(squareData)

		if not target:
			var square = BingoSquare.instantiate()
			square.setState(fontSize, text, score, texture, altText)
			return square
		else:
			# used for setting a new state on an existing square
			target.setState(fontSize, text, score, texture, altText)
	return

func _getFontSizeByContent(cellData):
	var fontSizeAdjust
	var text
	if cellData.has("fontSizeAdjust"):
		fontSizeAdjust = cellData["fontSizeAdjust"]
	if cellData.has("title"):
		text = cellData["title"]
	var newFontSize = getFontSize(text, Game.gridSize) + fontSizeAdjust
	return newFontSize

func _getTitleFromCellData(cellData):
	if cellData["ignoreTitle"] or not cellData.has("title"):
		return defaults["text"]
	return cellData["title"]

func _getScoreFromCellData(cellData):
	if cellData.has("rarity"):
		return cellData["rarity"]
	return defaults["score"]

func _getImagepathFromCellData(cellData):
	if cellData.has("filename") and cellData["filename"].length():
		return cellData["filename"]
	return defaults["image"]

func _getAltTextFromCellData(cellData):
	if cellData.has("tooltip") and cellData["tooltip"].length():
		return cellData["tooltip"]
	return defaults["altText"]

#############
# Core Utils

func getJSONData(filepath: String):
	if FileAccess.file_exists(filepath):
		var jsonText = FileAccess.get_file_as_string(filepath)
		var data = JSON.parse_string(jsonText)
		return data

func getJSONCategoryCounts(gameData: Dictionary):
	# Return:
	# {
	#    "category1": 3
	#    "category2": 2
	# }
	var subcategoryCounts: Dictionary = {
		"all": gameData.data.size(),
		"uncategorized": 0
	}
	for e in gameData.data:
		if len(e.subCategories) > 0 and subcategoryCounts.has(e.subCategories[0]):
			subcategoryCounts[e.subCategories[0]] += 1
		elif len(e.subCategories) > 0:
			subcategoryCounts[e.subCategories[0]] = 1
		else:
			subcategoryCounts["uncategorized"] += 1
	print(subcategoryCounts)
	return subcategoryCounts

#############
# Misc stuff

func formatTooltipText(string, len = 45):
	var splits = string.split(" ")
	var lines = []
	var line = ""
	for i in splits.size():
		if not line.length():
			line += str(splits[i])
		else:
			line += " %s" % str(splits[i])
		# if the next word would make the string too long
		if line.length() + splits[i].length() > len:
			lines.append(line)
			line = ""
	lines.append(line)
	return "\n".join(lines)

func getFontSize(text: String, gridSize: int):
	return defaults["fontSize"][str(gridSize)]
