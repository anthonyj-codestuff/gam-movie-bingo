extends Node2D

@onready var nameNode = get_node("VBoxContainer/LabelGameMode")

func _ready():
	nameNode.text = Game.currentGameTitle
