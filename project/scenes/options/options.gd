extends Node2D

@onready var OptionsBox = get_node("ScrollContainer/VBoxContainer")
var OptionScenePacked = preload("res://scenes/options/OptionsItem.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	var categories = [
		{"category": "one", "count": 10},
		{"category": "two", "count": 8},
		{"category": "three", "count": 14}
	]
	var newOption = OptionScenePacked.instantiate()
	newOption.setState(categories, "New Option", "desc:String", load("res://assets/images/mode-logos/christian2.png"))
	OptionsBox.add_child(newOption)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_back_pressed():
	get_tree().change_scene_to_file("res://scenes/menu.tscn")
