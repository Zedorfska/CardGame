extends Node

var Player1HP
var Player2HP

#
var Table
var Player1Table
var Player2Table

#
var Player1Hand
var Player2Hand

var Stats

var Turn
var TopCardInDeck
var Deck
var SelectedTile
var SelectedCard
var RandomTile
var RandomCard
var CurrentClearedTable
var RootNode

var HoverSound
var SelectSound

var TestCard = preload("res://Cards/TestCard/test_card.tscn")

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
	RootNode = $"."
	Player1HP = 20
	Player2HP = 20
	Deck = $CanvasLayer/Control/Root/Stats/Deck
	Turn = 0
	
	Table = $CanvasLayer/Control/Root/Middle
	Player1Table = $CanvasLayer/Control/Root/Middle/Player1Table
	Player2Table = $CanvasLayer/Control/Root/Middle/Player2Table
	
	Player1Hand = $CanvasLayer/Control/Root/Middle/Player1Hand
	Player2Hand = $CanvasLayer/Control/Root/Middle/Player2Hand
	
	Stats = $CanvasLayer/Control/Root/Stats
	
	SelectedTile = $CanvasLayer/Control/Root/Middle/Player1Table/Player1Card1/Marker2D
	
	HoverSound = $HoverSound
	SelectSound = $SelectSound
	
	update_player_health()
	setup_deck()	# fills the deck!
	deal_cards()	# deals the cards!
	
	player2_play_random_card()
	player2_play_random_card()
	
	tile_selected(0)	# TODO: BOTCH - necessary because shit breaks when not selected
	print("ready")

func setup_deck():
	for Card in range(ListOfCards.size()):
		Deck.add_child(ListOfCards[Card].instantiate())

func deal_cards():
	for HandToBeDealtTo in 6:
		if Deck.get_child_count() > 1:
			TopCardInDeck = Deck.get_child(1)
			var Player1HandToBeDealtTo = Player1Hand.get_child(HandToBeDealtTo).get_child(0)
			if Player1HandToBeDealtTo.get_child_count() == 0:
				TopCardInDeck.reparent(Player1HandToBeDealtTo, false)

		if Deck.get_child_count() > 1:
			TopCardInDeck = Deck.get_child(1)
			var Player2HandToBeDealtTo = Player2Hand.get_child(HandToBeDealtTo).get_child(0)
			if Player2HandToBeDealtTo.get_child_count() == 0:
				TopCardInDeck.reparent(Player2HandToBeDealtTo, false)

func player2_play_random_card():
	var ValidTileList = []											# Create list of valid tiles
	var ValidCardList = []
	for Tile in 4:													# Go through tiles
		var CheckValidTile = Player2Table.get_child(Tile).get_child(0)
		if CheckValidTile.get_child_count() == 0:					# If this tile is empty:
			ValidTileList.append(CheckValidTile)					#	Append it to the list of tiles
	for Card in 6:													# Go through cards
		var CheckValidCard = Player2Hand.get_child(Card).get_child(0)
		if CheckValidCard.get_child_count() != 0:					# If there is a card here:
			ValidCardList.append(CheckValidCard)					#	Append it to the list of cards
	if ValidTileList.is_empty() == false and ValidCardList.is_empty() == false:	# Check if lists empty
		RandomCard = ValidCardList.pick_random()
		RandomTile = ValidTileList.pick_random()
		RandomCard.get_child(0).reparent(RandomTile, false)

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
	SelectedCard = Player1Hand.get_child(CardNumber).get_child(0)
	if SelectedCard.get_child_count() != 0 and SelectedTile.get_child_count() == 0:
		SelectedCard.get_child(0).reparent(SelectedTile, false)

func player_take_damage(Player, Damage):
	if Player == 2:
		Player1HP -= Damage
	else:
		Player2HP -= Damage
	update_player_health()
	

func update_player_health():
	Stats.get_child(0).get_child(2).set_text(str(Player2HP))
	Stats.get_child(2).get_child(2).set_text(str(Player1HP))

func end_turn():
	for CardPosition in 4:
		if Player1Table.get_child(CardPosition).get_child(0).get_child_count() != 0:
			SelectedCard = Player1Table.get_child(CardPosition).get_child(0).get_child(0)
			print("Card ", CardPosition + 1, " of P1 attacks")
			SelectedCard.activate(RootNode, CardPosition, 1)
	player2_play_random_card()
	if 0.75 > randf():
		player2_play_random_card()
		if 0.5 > randf():
			player2_play_random_card()
			if 0.25 > randf():
				player2_play_random_card()
	for CardPosition in 4:
		print(CardPosition)
		if Player2Table.get_child(CardPosition).get_child(0).get_child_count() != 0:
			print(Player2Table.get_child(CardPosition).get_name())
			SelectedCard = Player2Table.get_child(CardPosition).get_child(0).get_child(0)
			SelectedCard.activate(RootNode, CardPosition, 2)
	deal_cards()

# Types of attacks cards can do
# Attacks card opposite of it, else the player.
func basic_common_attack(CardPosition, Damage, DamageType, Player):
	if Table.get_child(Player).get_child(CardPosition).get_child(0).get_child_count() != 0:
		Table.get_child(Player).get_child(CardPosition).get_child(0).get_child(0).take_damage(Damage, DamageType)
	else:
		player_take_damage(Player, Damage)
