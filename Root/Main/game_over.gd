extends TextureRect

var StartMenuScene = load("res://Root/Main/start_screen.tscn")
var VictoryLabel

func _ready():
	VictoryLabel = $VictoryLabel
	VictoryLabel.set_text(str("Player ", self.get_parent().PlayerWon, " wins!"))

func restart_game():
	self.get_parent().go_to_scene(StartMenuScene)
	self.queue_free()
