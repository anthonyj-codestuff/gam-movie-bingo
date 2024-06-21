extends Node
const MODULE_NAME = "Utils"
#var logger = LogWriter.new()
var BingoSquare = preload("res://global/BingoSquare.tscn")

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
