extends CanvasLayer

@onready var NameBox = $Control/HBoxContainer/Middle/Middle/BoxContainer/P1/BoxContainer/TextEdit
var Name
var GameScene = preload("res://Root/Main/Main.tscn")
var SceneTo = preload("res://Root/Main/Main.tscn")

func update_name():
	self.get_parent().Name = NameBox.text

func start_game():
	self.get_parent().go_to_scene(GameScene)
