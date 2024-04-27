extends MarginContainer

var textContents:String

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var textLabel = get_node("VBoxContainer/RichTextLabel")
	if textLabel.size.y > size.x:
		# VERY HACKY - if the text label is taller than the square is wide
		print(textLabel)
		var newFontSize = textLabel["theme_override_font_sizes/normal_font_size"] - 1
		textLabel.add_theme_font_size_override("normal_font_size", newFontSize)
		print(str(textLabel["theme_override_font_sizes/normal_font_size"]) + " -> " + str(newFontSize))

func setState(fontSize:int, text:String, image:Texture2D):
	get_node("VBoxContainer/RichTextLabel").text = "[center]" + text + "[/center]"
	get_node("VBoxContainer/RichTextLabel").add_theme_font_size_override("font_size", fontSize)
	get_node("TextureRect").set_texture(image)
	textContents = text

func _on_click_button_pressed():
	if Game.pruneMode and Game.prunesRemaining > 0:
		pruneSquare()
		handleSquarePruned()
	elif Game.pruneMode:
		Game.disablePruning()
		toggleTick()
	else:
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
	self.setState(30, text, image)

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
