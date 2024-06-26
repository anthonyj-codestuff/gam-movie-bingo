extends Control

var CategoryBox
var LogoImage
var LabelName
var LabelDesc
var OptionSubcategoryPacked = preload("res://scenes/options/OptionSubcategory.tscn")
var gameModeId: int
var gameItemsFullList: Array[Dictionary] = []
var gameItemsFiltered: Array[Dictionary] = []
var subcategoryNodesList: Array = []
var mat = ShaderMaterial.new()

func _ready():
	SignalBus.game_mode_subcategory_check_box_toggled.connect(_on_subcategory_selected)
	pass

func setState(subcategories:Dictionary, gameData: Dictionary):
	# set locally important data
	gameModeId = gameData["id"]
	gameItemsFullList = Array(gameData["data"], TYPE_DICTIONARY, &"", null)
	gameItemsFiltered = Array(gameData["data"], TYPE_DICTIONARY, &"", null)
	# gather important nodes
	CategoryBox = get_node("MarginContainer/HBoxContainer/VBoxContainer/ScrollContainer/HBoxContainer")
	LogoImage = get_node("MarginContainer/HBoxContainer/LogoImage")
	LabelName = get_node("MarginContainer/HBoxContainer/VBoxContainer/LabelName")
	LabelDesc = get_node("MarginContainer/HBoxContainer/VBoxContainer/LabelDesc")
	# shader for inactive options
	mat.shader = load("res://assets/shaders/greyscale.gdshader")

	# set data to OptionsItem scene
	LogoImage.set_texture(load(gameData["logo"]))
	LabelName.text = gameData["title"]
	LabelDesc.text = gameData["description"]
	if not gameData["active"]:
		LogoImage.material = mat
		LabelName.text = LabelName.text + " (inactive)"

	# Spawn category buttons with labels
	for key in subcategories:
		var category = key
		var count = subcategories[key]
		var disabled = (category in ["all", "uncategorized"])
		var newSubcategory = OptionSubcategoryPacked.instantiate()
		newSubcategory.setState(category, count, disabled, gameData["id"])
		CategoryBox.add_child(newSubcategory)
		subcategoryNodesList.append(newSubcategory)

func _addSubcategoryToList(subcategoryName: String):
	for i in gameItemsFullList:
		if i["subCategories"].has(subcategoryName):
			gameItemsFiltered.append(i)

func _removeSubcategoryFromList(subcategoryName: String):
	var i = 0
	while i < gameItemsFiltered.size():
		if gameItemsFiltered[i]["subCategories"].has(subcategoryName):
			gameItemsFiltered.pop_at(i)
			i -= 1
		i += 1

func _on_subcategory_selected(subcategoryName: String, emitterParentId: int, toggled: bool):
	# could not be asked to avoid using a signalBus, so this gets triggered once for each mode
	if not emitterParentId == gameModeId:
		return
	if subcategoryName != "all" and not toggled:
		# deselecting any box should re-enable All
		subcategoryNodesList[0].setDisabled(false)
		subcategoryNodesList[0].setTick(false)
	if subcategoryName == "all" and toggled:
		# selecting All should select all of the boxes and disable All
		for c in subcategoryNodesList:
			if c.subcategoryName == "all":
				c.setDisabled(true)
			c.setTick(true)
		return
	elif toggled:
		_addSubcategoryToList(subcategoryName)
	elif not toggled:
		_removeSubcategoryFromList(subcategoryName)
	else:
		print("invalid state ", subcategoryName, emitterParentId, toggled)

func _on_game_mode_select_button_pressed():
	print("_on_game_mode_select_button_pressed")
	for i in gameItemsFiltered:
		print(i["title"])
	print(gameItemsFiltered.size())
