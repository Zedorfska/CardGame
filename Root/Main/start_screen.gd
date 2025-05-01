extends CanvasLayer

@onready var NameBox = $Control/HBoxContainer/Middle/Middle/BoxContainer/P1/BoxContainer/TextEdit
var Name
var GameScene = preload("res://Root/Main/Main.tscn")
var SceneTo = preload("res://Root/Main/Main.tscn")

func update_name():
	self.get_parent().Name = NameBox.text

func start_game():
	if NameBox.get_text() == "":
		NameBox.set_placeholder("ENTER NAME!!!")
	else:
		self.get_parent().go_to_scene(GameScene)

func _ready():
	if self.get_parent().Name != null:
		NameBox.set_text(self.get_parent().Name)
