extends Node

var Table1A

var TestCard = preload("res://TestCard.tscn")

func _ready():
	Table1A = $CanvasLayer/Control/Root/Middle/Player1Table/Player1Card1
	print("ready")
	print(TestCard)

# temp
func _on_button_pressed() -> void:
	var TestCardInstance = TestCard.instantiate()
	Table1A.add_child(TestCardInstance)
	print("a")
