extends Button

const GameModes = {
	"conspiracy": "res://assets/game-modes/conspiracy.json",
	"christian-classic": "res://assets/game-modes/christian-classic.json"
}

# Called when the node enters the scene tree for the first time.
func _ready():
	var name = "christian-classic"
	if FileAccess.file_exists(GameModes[name]):
		var jsonText = FileAccess.get_file_as_string(GameModes[name])
		var data = JSON.parse_string(jsonText)
		Game.currentGameData = data
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_pressed():
	loadGameMode("conspiracy")
	pass # Replace with function body.

func loadGameMode(name: String):
	if FileAccess.file_exists(GameModes[name]):
		var jsonText = FileAccess.get_file_as_string(GameModes[name])
		var data = JSON.parse_string(jsonText)
		Game.currentGameData = data
		print(Game.currentGameData.title)
		var dict: Dictionary = {}
		for e in data.data:
			if len(e.subCategories) > 0 and dict.has(e.subCategories[0]):
				dict[e.subCategories[0]] += 1
			elif len(e.subCategories) > 0:
				dict[e.subCategories[0]] = 1
		print(dict)
