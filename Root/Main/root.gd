extends Node

var StartMenu
var Name
var StartMenuScene = preload("res://Root/Main/start_screen.tscn")
var GameScene = preload("res://Root/Main/Main.tscn")
var GameOverScene = preload("res://Root/Main/game_over.tscn")

var ColorSafe = Color(0.0, 0.6235294117647059, 0.4196078431372549)
var ColorEuclid = Color(1.0, 0.8274509803921568, 0.0)
var ColorKeter = Color(0.7686274509803922, 0.00784313725490196, 0.2)

func _ready():
	go_to_scene(StartMenuScene)

func go_to_scene(Scene):
	for i in self.get_child_count():
		self.get_child(0).queue_free()
	self.add_child(Scene.instantiate())

func pass_table():
	pass
