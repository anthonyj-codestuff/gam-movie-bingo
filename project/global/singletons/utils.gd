extends Node
const MODULE_NAME = "Utils"
#var logger = LogWriter.new()
var BingoSquare = preload("res://scenes/BingoSquare.tscn")

const defaults = {
	"fontSize": 30,
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
		var fontSize = _getFontSizeFromCellData(squareData)
		var text = _getTitleFromCellData(squareData)
		var score = _getScoreFromCellData(squareData)
		var texture = load(_getImagepathFromCellData(squareData))
		var altText = _getAltTextFromCellData(squareData)

		if not target:
			var square = BingoSquare.instantiate()
			square.setState(fontSize, text, score, texture, altText)
			return square
		else:
			target.setState(fontSize, text, score, texture, altText)
	return

func _getFontSizeFromCellData(cellData):
	if cellData.has("fontSizeAdjust"):
		return defaults["fontSize"] + cellData["fontSizeAdjust"]
	return defaults["fontSize"]

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
