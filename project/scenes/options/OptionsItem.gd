extends Control

var CategoryBox
var LogoImage
var LabelName
var LabelDesc
var OptionCategoryPacked = preload("res://scenes/options/OptionCategory.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func setState(categories:Array, name:String, desc:String, logo:Resource):
	CategoryBox = get_node("MarginContainer/HBoxContainer/VBoxContainer/ScrollContainer/HBoxContainer")
	LogoImage = get_node("MarginContainer/HBoxContainer/LogoImage")
	LabelName = get_node("MarginContainer/HBoxContainer/VBoxContainer/LabelName")
	LabelDesc = get_node("MarginContainer/HBoxContainer/VBoxContainer/LabelDesc")

	LogoImage.set_texture(logo)
	LabelName.text = name
	LabelDesc.text = desc
	# categories = [
	#				 {"category": "name", "count": 3}
	#			   ]
	for i in categories:
		var category = i["category"]
		var count = i["count"]
		var newCategory = OptionCategoryPacked.instantiate()
		newCategory.setState(category, count)
		CategoryBox.add_child(newCategory)
	pass
