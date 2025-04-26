extends TextureRect

var StartMenuScene = load("res://Root/Main/start_screen.tscn")

func restart_game():
	self.get_parent().go_to_scene(StartMenuScene)
	self.queue_free()
