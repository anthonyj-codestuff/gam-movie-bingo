extends Button

func _ready():
	var name = "christian-classic"
	var filename = Game.gameModeFiles[name]
	if FileAccess.file_exists(filename):
		var jsonText = FileAccess.get_file_as_string(filename)
		var data = JSON.parse_string(jsonText)
		Game.currentGameData = data

func _process(delta):
	pass

func _on_pressed():
	loadGameMode("conspiracy")

func loadGameMode(name: String):
	var filename = Game.gameModeFiles[name]
	var gameData = Utils.getJSONData(filename)
	Game.currentGameData = gameData
	print(Game.currentGameData.title)
