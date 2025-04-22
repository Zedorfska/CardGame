extends Node

#
var Player1Table
var Player2Table

#
var Player1Hand
var Player2Hand

var turn
var TopCardInDeck
var Deck
var SelectedTile
var SelectedCard
var CurrentClearedTable

var HoverSound
var SelectSound

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
	TestCard,
	TestCard
]

func _ready():
	Deck = $CanvasLayer/Control/Root/Left/Deck
	turn = 0
	# 2x4 TABLE DECLARE
	Player1Table = $CanvasLayer/Control/Root/Middle/Player1Table
	Player2Table = $CanvasLayer/Control/Root/Middle/Player2Table
	
	Player1Hand = $CanvasLayer/Control/Root/Middle/Player1Hand
	Player2Hand = $CanvasLayer/Control/Root/Middle/Player2Hand
	
	SelectedTile = $CanvasLayer/Control/Root/Middle/Player1Table/Player1Card1/Marker2D
	
	HoverSound = $HoverSound
	SelectSound = $SelectSound
	
	setup_deck()	# fills the deck!
	deal_cards()	# deals the cards!
	
	tile_selected(0)	# TODO: BOTCH - necessary because shit breaks when not selected
	print("ready")

func setup_deck():
	for Card in range(ListOfCards.size()):
		Deck.add_child(ListOfCards[Card].instantiate())

func deal_cards():
	for HandToBeDealtTo in 6:
		TopCardInDeck = Deck.get_child(1)
		var Player1HandToBeDealtTo = Player1Hand.get_child(HandToBeDealtTo).get_child(0)
		if Player1HandToBeDealtTo.get_child_count() < 1:
			TopCardInDeck.reparent(Player1HandToBeDealtTo, false)

		TopCardInDeck = Deck.get_child(1)
		var Player2HandToBeDealtTo = Player2Hand.get_child(HandToBeDealtTo).get_child(0)
		if Player2HandToBeDealtTo.get_child_count() < 1:
			TopCardInDeck.reparent(Player2HandToBeDealtTo, false)


func tile_hover_enter(TileNumber):
	Player1Table.get_child(TileNumber).get_child(1).visible = true
	HoverSound.play()

func tile_hover_exit(TileNumber):
	Player1Table.get_child(TileNumber).get_child(1).visible = false

func tile_selected(TileNumber):
	for CurrentSelectedTile in 4:
		var SelectedTileSelector = Player1Table.get_child(CurrentSelectedTile).get_child(2)
		var DesiredTileSelector = Player1Table.get_child(TileNumber).get_child(2)
		if SelectedTileSelector == DesiredTileSelector:
			SelectedTileSelector.visible = true
		else:
			SelectedTileSelector.visible = false
	SelectedTile = Player1Table.get_child(TileNumber).get_child(0)
	SelectSound.play()

func card_selected(CardNumber):
	var CurrentCardSelected = Player1Hand.get_child(CardNumber).get_child(0)
	if CurrentCardSelected.get_child_count() > 0 and SelectedTile.get_child_count() < 1:
		CurrentCardSelected.get_child(0).reparent(SelectedTile, false)

#func _process(_delta):
	#print(SelectedCard)
