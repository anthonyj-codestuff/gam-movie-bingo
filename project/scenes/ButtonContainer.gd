extends VBoxContainer


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _on_button_easy_pressed():
	Game.gridSize = 3
	get_tree().change_scene_to_file("res://scenes/gameboard.tscn")


func _on_button_medium_pressed():
	Game.gridSize = 4
	get_tree().change_scene_to_file("res://scenes/gameboard.tscn")


func _on_button_hard_pressed():
	Game.gridSize = 5
	get_tree().change_scene_to_file("res://scenes/gameboard.tscn")


func _on_button_daring_pressed():
	Game.gridSize = 6
	get_tree().change_scene_to_file("res://scenes/gameboard.tscn")
