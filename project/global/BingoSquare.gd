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
	size = Vector2(width, height)
	get_node("VBoxContainer/RichTextLabel").text = "[center]" + text + "[/center]"
	get_node("VBoxContainer/RichTextLabel").add_theme_font_size_override("font_size", fontSize)
	textContents = text


func _on_click_button_pressed():
	print(textContents)
