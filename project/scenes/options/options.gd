extends Node2D

@onready var OptionsBox = get_node("ScrollContainer/VBoxContainer")
var OptionScenePacked = preload("res://scenes/options/OptionsItem.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	for key in Game.gameModeFiles:
		var data = Utils.getJSONData(Game.gameModeFiles[key])
		var categoriesCount = Utils.getJSONCategoryCounts(data)
		var newOption = OptionScenePacked.instantiate()
		newOption.setState(categoriesCount, data)
		OptionsBox.add_child(newOption)

func _on_back_pressed():
	get_tree().change_scene_to_file("res://scenes/menu.tscn")
