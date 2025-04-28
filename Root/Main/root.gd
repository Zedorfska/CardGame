extends Node

var StartMenu
var Name
var StartMenuScene = preload("res://Root/Main/start_screen.tscn")
var GameScene = preload("res://Root/Main/Main.tscn")
var GameOverScene = preload("res://Root/Main/game_over.tscn")

@onready var CardAttackMoveAmount = 50

func _ready():
	go_to_scene(StartMenuScene)

func go_to_scene(Scene):
	for i in self.get_child_count():
		self.get_child(0).queue_free()
	self.add_child(Scene.instantiate())
