extends Node

#
var Table1A
var Table2A
var Table3A
var Table4A

var Table1B
var Table2B
var Table3B
var Table4B

#
var Player1Hand
var Player1Hand1
var Player1Hand2
var Player1Hand3
var Player1Hand4
var Player1Hand5
var Player1Hand6

var Player2Hand
var Player2Hand1
var Player2Hand2
var Player2Hand3
var Player2Hand4
var Player2Hand5
var Player2Hand6

var turn
var TopCardInDeck
var Deck

var TestCard = preload("res://Cards/TestCard/TestCard.tscn")

var ListOfCards = [
	TestCard,
	TestCard,
	TestCard,
	TestCard,
	TestCard,
	TestCard,
	TestCard,
	TestCard,
	TestCard,
	TestCard,
	TestCard,
	TestCard
]

func _ready():
	Deck = $CanvasLayer/Control/Root/Left/Deck
	turn = 0
	# 2x4 TABLE DECLARE
	Table1A = $CanvasLayer/Control/Root/Middle/Player1Table/Player1Card1
	Table2A = $CanvasLayer/Control/Root/Middle/Player2Table/Player2Card2
	Table3A = $CanvasLayer/Control/Root/Middle/Player2Table/Player2Card3
	Table4A = $CanvasLayer/Control/Root/Middle/Player2Table/Player2Card4
	Table1B = $CanvasLayer/Control/Root/Middle/Player1Table/Player1Card1
	Table2B = $CanvasLayer/Control/Root/Middle/Player1Table/Player1Card2
	Table3B = $CanvasLayer/Control/Root/Middle/Player1Table/Player1Card3
	Table4B = $CanvasLayer/Control/Root/Middle/Player1Table/Player1Card4
	
	Player1Hand = $CanvasLayer/Control/Root/Middle/Player1Hand
	Player1Hand1 = $CanvasLayer/Control/Root/Middle/Player1Hand/Player1Card1
	Player1Hand2 = $CanvasLayer/Control/Root/Middle/Player1Hand/Player1Card2
	Player1Hand3 = $CanvasLayer/Control/Root/Middle/Player1Hand/Player1Card3
	Player1Hand4 = $CanvasLayer/Control/Root/Middle/Player1Hand/Player1Card4
	Player1Hand5 = $CanvasLayer/Control/Root/Middle/Player1Hand/Player1Card5
	Player1Hand6 = $CanvasLayer/Control/Root/Middle/Player1Hand/Player1Card6
	Player2Hand = $CanvasLayer/Control/Root/Middle/Player2Hand
	Player2Hand1 = $CanvasLayer/Control/Root/Middle/Player2Hand/Player2Card1
	Player2Hand2 = $CanvasLayer/Control/Root/Middle/Player2Hand/Player2Card2
	Player2Hand3 = $CanvasLayer/Control/Root/Middle/Player2Hand/Player2Card3
	Player2Hand4 = $CanvasLayer/Control/Root/Middle/Player2Hand/Player2Card4
	Player2Hand5 = $CanvasLayer/Control/Root/Middle/Player2Hand/Player2Card5
	Player2Hand6 = $CanvasLayer/Control/Root/Middle/Player2Hand/Player2Card6
	print("ready")
	setup_deck()
	deal_cards()

func setup_deck():
	for Card in range(ListOfCards.size()):
		var CardInstance = ListOfCards[Card].instantiate()
		Deck.add_child(CardInstance)
	print(Deck)

func deal_cards():
	# kill yourself
	TopCardInDeck = Deck.get_child(1)
	if Player1Hand1.get_child_count() < 2:
		Deck.remove_child(TopCardInDeck)
		Player1Hand1.add_child(TopCardInDeck)
	TopCardInDeck = Deck.get_child(1)
	if Player1Hand2.get_child_count() < 2:
		Deck.remove_child(TopCardInDeck)
		Player1Hand2.add_child(TopCardInDeck)
	TopCardInDeck = Deck.get_child(1)
	if Player1Hand3.get_child_count() < 2:
		Deck.remove_child(TopCardInDeck)
		Player1Hand3.add_child(TopCardInDeck)
	TopCardInDeck = Deck.get_child(1)
	if Player1Hand4.get_child_count() < 2:
		Deck.remove_child(TopCardInDeck)
		Player1Hand4.add_child(TopCardInDeck)
	TopCardInDeck = Deck.get_child(1)
	if Player1Hand5.get_child_count() < 2:
		Deck.remove_child(TopCardInDeck)
		Player1Hand5.add_child(TopCardInDeck)
	TopCardInDeck = Deck.get_child(1)
	if Player1Hand6.get_child_count() < 2:
		Deck.remove_child(TopCardInDeck)
		Player1Hand6.add_child(TopCardInDeck)
	
	TopCardInDeck = Deck.get_child(1)
	if Player2Hand1.get_child_count() < 2:
		Deck.remove_child(TopCardInDeck)
		Player2Hand1.add_child(TopCardInDeck)
	TopCardInDeck = Deck.get_child(1)
	if Player2Hand2.get_child_count() < 2:
		Deck.remove_child(TopCardInDeck)
		Player2Hand2.add_child(TopCardInDeck)
	TopCardInDeck = Deck.get_child(1)
	if Player2Hand3.get_child_count() < 2:
		Deck.remove_child(TopCardInDeck)
		Player2Hand3.add_child(TopCardInDeck)
	TopCardInDeck = Deck.get_child(1)
	if Player2Hand4.get_child_count() < 2:
		Deck.remove_child(TopCardInDeck)
		Player2Hand4.add_child(TopCardInDeck)
	TopCardInDeck = Deck.get_child(1)
	if Player2Hand5.get_child_count() < 2:
		Deck.remove_child(TopCardInDeck)
		Player2Hand5.add_child(TopCardInDeck)
	TopCardInDeck = Deck.get_child(1)
	if Player2Hand6.get_child_count() < 2:
		Deck.remove_child(TopCardInDeck)
		Player2Hand6.add_child(TopCardInDeck)
