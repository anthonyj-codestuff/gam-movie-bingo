extends MarginContainer

var textContents:String

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func setState(width:int, height:int, fontSize:int, text:String, image:Texture2D):
	print("creating new square with " + str(width) + " " + str(height) + " " + str(fontSize) + " " + text)
	print(size)
	size = Vector2(width, height)
	print(size)
	# Texture
	# print("TextureRect Before" + str(get_node("TextureRect").size))
	get_node("TextureRect").texture = image
	get_node("TextureRect").size = Vector2(width, height)
	# print("TextureRect After" + str(get_node("TextureRect").size))
	# Vbox
	# print("VBox Before" + str(get_node("VBoxContainer").size))
	get_node("VBoxContainer").size = Vector2(width, height)
	# print("VBox After" + str(get_node("VBoxContainer").size))
	# Label
	get_node("VBoxContainer/RichTextLabel").text = "[center]" + text + "[/center]"
	get_node("VBoxContainer/RichTextLabel").size.x = width
	get_node("VBoxContainer/RichTextLabel").add_theme_font_size_override("font_size", fontSize)
	textContents = text


func _on_click_button_pressed():
	print(textContents)
