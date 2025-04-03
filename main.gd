extends Node

var Table1A

var TestCard = preload("res://TestCard.tscn")
var ListOfCards = [
	TestCard
]
var Deck = []

func _ready():
	Table1A = $CanvasLayer/Control/Root/Middle/Player1Table/Player1Card1
	print("ready")
	refill_deck()

func refill_deck():
	for Card in range(ListOfCards.size()):
		print(Card)
		Deck.append(ListOfCards[Card])
	print(Deck)


# temp
func _on_button_pressed() -> void:
	var TestCardInstance = TestCard.instantiate()
	Table1A.add_child(TestCardInstance)
	print("a")
