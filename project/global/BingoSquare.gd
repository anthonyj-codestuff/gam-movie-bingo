extends MarginContainer

var textContents:String
var pointValue:int

func _ready():
	pass

func _process(delta):
	var textLabel = get_node("VBoxContainer/RichTextLabel")
	if textLabel.size.y > size.x:
		# VERY HACKY - if the text label is taller than the square is wide
		print(textLabel)
		var newFontSize = textLabel["theme_override_font_sizes/normal_font_size"] - 1
		textLabel.add_theme_font_size_override("normal_font_size", newFontSize)
		print(str(textLabel["theme_override_font_sizes/normal_font_size"]) + " -> " + str(newFontSize))
	if Game.pruneMode:
		get_node("TextureRect").material.set_shader_parameter("active", true)
	else:
		get_node("TextureRect").material.set_shader_parameter("active", false)

func getPointValue()->int:
	return pointValue

func setState(fontSize:int, text:String, score:int, image:Texture2D, altText:String):
	pointValue = score
	get_node("VBoxContainer/RichTextLabel").text = "[center]" + text + "[/center]"
	get_node("VBoxContainer/RichTextLabel").add_theme_font_size_override("font_size", fontSize)
	get_node("TextureRect").set_texture(image)
	get_node("PointsBox/PointsLabel").text = str(score)
	var tooltipBox = get_node("TooltipBox")
	if altText.length():
		tooltipBox.visible = true
		tooltipBox.tooltip_text = Utils.formatTooltipText(altText)
	else:
		tooltipBox.visible = false
		tooltipBox.tooltip_text = ""
	textContents = text

func _on_click_button_pressed():
	# if user has turned on pruning, prune square
	if Game.pruneMode and Game.prunesRemaining > 0:
		pruneSquare()
		handleSquarePruned()
	# if user has no prunes left, disable pruning and tick
	# TODO I don't think this does anything, find out why
	elif Game.pruneMode:
		Game.disablePruning()
		toggleTick()
	# remove the pruning option if the user ticks a box
	else:
		Game.disablePruning()
		toggleTick()

func toggleTick():
	var isVisible = self.get_node("Tick").visible
	self.get_node("Tick").visible = !isVisible

func pruneSquare():
	var gameData = Game.getGameSquareData()
	# get a new node that's not on the list, add its index to the list
	var randInt = randi_range(0, len(gameData)-1)
	while Game.currentBoard.has(randInt):
		randInt = randi_range(0, len(gameData)-1)
	var cell = gameData[randInt]
	Game.currentBoard.push_back(randInt)
	# set new properties 
	var image = load(cell.filename) if len(cell.filename) > 0 else null
	var text = "" if cell.ignoreTitle else cell.title
	var score = cell.rarity
	self.setState(30, text, score, image)

func handleSquarePruned():
	if Game.unlimitedPrunes:
		pass
	else:
		Game.prunesRemaining -= 1
		if Game.prunesRemaining == 0:
			Game.disablePruning()
		elif Game.prunesRemaining < 0:
			Game.disablePruning()
			print("Warn: Prunes less than 0, setting to zero")
			Game.prunesRemaining = 0
