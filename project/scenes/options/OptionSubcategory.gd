extends Control
@export var parentId: int
@export var subcategoryName: String
@export var count: int
var checkboxNode

func _ready():
	get_node("CenterContainer/HBox/VBox/Label").text = subcategoryName
	get_node("CenterContainer/HBox/VBox/HBox2/Label2").text = "("+str(count)+")"
	checkboxNode = get_node("CenterContainer/HBox/VBox/HBox2/CheckBox")

func setState(name:String, num:int, disabled:bool, parent: int):
	subcategoryName = name
	count = num
	parentId = parent
	get_node("CenterContainer/HBox/VBox/HBox2/CheckBox").disabled = disabled

func isTicked():
	return checkboxNode.button_pressed

func setTick(ticked: bool):
	checkboxNode.button_pressed = ticked

func setDisabled(disabled: bool):
	checkboxNode.disabled = disabled

func _on_check_box_toggled(toggled_on):
	SignalBus.game_mode_subcategory_check_box_toggled.emit(subcategoryName, parentId, toggled_on)
