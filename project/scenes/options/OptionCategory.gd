extends Control
@export var categoryName: String
@export var count: int

func _ready():
	get_node("CenterContainer/HBoxContainer/VBoxContainer/Label").text = categoryName
	get_node("CenterContainer/HBoxContainer/VBoxContainer/Label2").text = "("+str(count)+")"

func setState(name:String, num:int):
	categoryName = name
	count = num

func isTicked():
	return get_node("CenterContainer/HBoxContainer/CheckBox").button_pressed
