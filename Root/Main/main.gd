extends Node

var Table
var Name
var Player1Table
var Player2Table
var Hands
var Player1Hand
var Player2Hand
var Player1HP
var Player2HP
var P1Mana
var P2Mana
var P1ManaBar
var P2ManaBar
var CardDisplay
var ContainmentClassIcon
var CardDescriptionLabel
var CardNameLabel
var TurnCountLabel
var AbleToPlay

var Stats
var ManaGainAmount
var CardGainAmount

var Turn
var TopCardInDeck
var Deck
var SelectedTile
var SelectedCard
var RandomTile
var RandomCard
var Get
var CurrentClearedTable
var RootNode

var HoverSound
var SelectSound

var GameOverScene = preload("res://Root/Main/game_over.tscn")

var ManaBarScene = preload("res://Root/Labels/mana_bar.tscn")

const CardFunctions = preload("res://Cards/card_functions.gd")

var SafeIcon = preload("res://Sprites/SCPContainmentIcons/Safe.svg")
var EuclidIcon = preload("res://Sprites/SCPContainmentIcons/Euclid.svg")
var KeterIcon = preload("res://Sprites/SCPContainmentIcons/Keter.svg")

var TestCard = preload("res://Cards/TestCard/test_card.tscn")
var SCP049 = preload("res://Cards/049/049/049.tscn")
var SCP173 = preload("res://Cards/173/173.tscn")
var SCP205 = preload("res://Cards/205/205/205.tscn")
var SCP207 = preload("res://Cards/207/207.tscn")

var ListOfCards = [
	SCP207,
	SCP049,
	TestCard,
	SCP049,
	SCP173,
	SCP173,
	SCP173,
	SCP205
]

func _ready():
	RootNode = $"."
	Player1HP = 20
	Player2HP = 20
	P1Mana = 1
	P2Mana = 1
	ManaGainAmount = 1
	CardGainAmount = 1
	Deck = $CanvasLayer/Control/Root/StatsContainer/Stats/Deck/Deck/Marker2D
	Turn = 0
	AbleToPlay = true
	
	CardDisplay = $CanvasLayer/Control/Root/RightContainer/Right/HoverCardDisplay/CardDisplayMarker/Sprite2D
	ContainmentClassIcon = $CanvasLayer/Control/Root/RightContainer/Right/HoverCardDisplay/ContainmentClassIcon
	CardNameLabel = $CanvasLayer/Control/Root/RightContainer/Right/LabelMargin/CardNameLabel
	CardDescriptionLabel = $CanvasLayer/Control/Root/RightContainer/Right/LabelMargin/CardDescription
	CardDescriptionLabel.set_text("Hover over a card to see description")
	TurnCountLabel = $CanvasLayer/Control/Root/RightContainer/Right/LabelMargin/TurnCountLabel
	TurnCountLabel.set_text(str("Turn: ", Turn))
	Table = $CanvasLayer/Control/Root/Table
	Player1Table = $CanvasLayer/Control/Root/Table/Player1Table
	Player2Table = $CanvasLayer/Control/Root/Table/Player2Table
	Player1Hand = $CanvasLayer/Control/Root/Table/Player1Hand
	Player2Hand = $CanvasLayer/Control/Root/Table/Player2Hand
	
	Stats = $CanvasLayer/Control/Root/StatsContainer/Stats
	Name = self.get_parent().Name
	Stats.get_child(2).get_child(0).set_text(Name)
	
	SelectedTile = $CanvasLayer/Control/Root/Table/Player1Table/Player1Card1/Marker2D
	
	HoverSound = $HoverSound
	SelectSound = $SelectSound
	
	Stats.get_child(0).get_child(2).add_child(ManaBarScene.instantiate())
	Stats.get_child(2).get_child(2).add_child(ManaBarScene.instantiate())
	P1ManaBar = Stats.get_child(2).get_child(2).get_child(0)
	P2ManaBar = Stats.get_child(0).get_child(2).get_child(0)
	P1ManaBar.update_label(P1Mana)
	P2ManaBar.update_label(P2Mana)
	
	CardFunctions.send_main_node(self)
	
	update_player_health()
	setup_deck()			# fills the deck!
	deal_cards_to_player(1, 3)	# deals the cards!
	deal_cards_to_player(2, 3)
	
	await get_tree().create_timer(0.75).timeout
	player2_play_random_card()
	player2_play_random_card()
	
	tile_selected(0)	# TODO: BOTCH - necessary because shit breaks when not selected
	print("ready")

func get_amount_of_active_cards():
	var Amount = 0
	for i in 4:
		if Table.get_child(1).get_child(i).get_child(0).get_child_count() != 0:
			Amount += 1
		if Table.get_child(2).get_child(i).get_child(0).get_child_count() != 0:
			Amount += 1
	return Amount

func setup_deck():
	for Card in range(ListOfCards.size()):
		Deck.add_child(ListOfCards[Card].instantiate())

func deal_cards_to_player(Player, Amount):
	var ChildToGet = 0
	if Player == 1:
		ChildToGet = 3
	for CurrentAmount in Amount:
		for HandToBeDealtTo in 6:
			if Table.get_child(ChildToGet).get_child(HandToBeDealtTo).get_child(0).get_child_count() == 0:
				if Deck.get_child_count() != 0:
					TopCardInDeck = Deck.get_child(-1)
					TopCardInDeck.reparent(Table.get_child(ChildToGet).get_child(HandToBeDealtTo).get_child(0), true)
					var tween = get_tree().create_tween()
					tween.tween_property(TopCardInDeck, "position", Vector2.ZERO, 0.1)
					await get_tree().create_timer(0.1).timeout
				break

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
			if CheckValidCard.get_child(0).CostAmount <= P2Mana:	# If there is enough mana to play it
				ValidCardList.append(CheckValidCard)					#	Append it to the list of cards
	if ValidTileList.is_empty() == false and ValidCardList.is_empty() == false:	# Check if lists empty
		RandomCard = ValidCardList.pick_random()
		RandomTile = ValidTileList.pick_random()
		P2Mana -= RandomCard.get_child(0).CostAmount
		P2ManaBar.update_label(P2Mana)
		RandomCard.get_child(0).reparent(RandomTile, true)
		var tween = get_tree().create_tween()
		tween.tween_property(RandomTile.get_child(0), "position", Vector2.ZERO, 0.1)

func update_displayed_card(HoveredCard):
	if HoveredCard == null:
		CardNameLabel.set_text("")
		CardDescriptionLabel.set_text("Hover over a card to see description")
		CardDisplay.visible = false
		ContainmentClassIcon.visible = false
	else:
		CardNameLabel.set_text(HoveredCard.SCPNumber)
		
		CardDescriptionLabel.set_text(HoveredCard.Description)
		
		CardDisplay.set_texture(HoveredCard.get_child(0).get_texture())
		CardDisplay.visible = true
		
		match HoveredCard.ContainmentClass:
			"Safe":
				ContainmentClassIcon.set_texture(SafeIcon)
			"Euclid":
				ContainmentClassIcon.set_texture(EuclidIcon)
			"Keter":
				ContainmentClassIcon.set_texture(KeterIcon)
		ContainmentClassIcon.visible = true

func tile_hover_enter(TileNumber):
	if TileNumber < 4:
		Player1Table.get_child(TileNumber).get_child(1).visible = true
		HoverSound.play()
		if Player1Table.get_child(TileNumber).get_child(0).get_child_count() != 0:
			update_displayed_card(Player1Table.get_child(TileNumber).get_child(0).get_child(0))
	else:
		if Player2Table.get_child(TileNumber - 4).get_child(0).get_child_count() != 0:
			update_displayed_card(Player2Table.get_child(TileNumber - 4).get_child(0).get_child(0))

func tile_hover_exit(TileNumber):
	if TileNumber < 4:
		Player1Table.get_child(TileNumber).get_child(1).visible = false
	update_displayed_card(null)

func card_hover_enter(CardNumber):
	if CardNumber < 6:
		if Player1Hand.get_child(CardNumber).get_child(0).get_child_count() != 0:
			update_displayed_card(Player1Hand.get_child(CardNumber).get_child(0).get_child(0))
	else:
		if Player2Hand.get_child(CardNumber - 6).get_child(0).get_child_count() != 0:
			update_displayed_card(Player2Hand.get_child(CardNumber - 6).get_child(0).get_child(0))

func card_hover_exit():
	update_displayed_card(null)

func tile_selected(TileNumber):
	if AbleToPlay == true:
		for CurrentSelectedTile in 4:
			var SelectedTileSelector = Player1Table.get_child(CurrentSelectedTile).get_child(2)
			var DesiredTileSelector = Player1Table.get_child(TileNumber).get_child(2)
			if SelectedTileSelector == DesiredTileSelector:
				SelectedTileSelector.visible = true
			else:
				SelectedTileSelector.visible = false
		SelectedTile = Player1Table.get_child(TileNumber).get_child(0)
		SelectSound.play()
	else:
		$DenySound.play()

func card_selected(CardNumber):
	if AbleToPlay == true:
		SelectedCard = Player1Hand.get_child(CardNumber).get_child(0)
		if SelectedCard.get_child_count() != 0 and SelectedTile.get_child_count() == 0:
			if SelectedCard.get_child(0).CostAmount <= P1Mana:
				P1Mana -= SelectedCard.get_child(0).CostAmount
				SelectedCard.get_child(0).reparent(SelectedTile, true)
				var tween = get_tree().create_tween()
				tween.tween_property(SelectedTile.get_child(0), "position", Vector2.ZERO, 0.1)
				
				AbleToPlay = false
				
				for TestedTile in 4:
					if SelectedTile == Table.get_child(2).get_child(TestedTile).get_child(0):
						SelectedTile.get_child(0).played(TestedTile, 1)
				
				await get_tree().create_timer(0.1).timeout
				P1ManaBar.update_label(P1Mana)
				AbleToPlay = true

func player_take_damage(Player, Damage):
	if Player == 2:
		Player1HP -= Damage
	else:
		Player2HP -= Damage
	
	if Player1HP <= 0 or Player2HP <= 0:
		self.get_parent().go_to_scene(GameOverScene)
	
	update_player_health()

func update_player_health():
	Stats.get_child(0).get_child(1).set_text(str(Player2HP))
	Stats.get_child(2).get_child(1).set_text(str(Player1HP))

func end_turn():
	if AbleToPlay == true:
		AbleToPlay = false
		for CardPosition in 4:			# Player 1 cards activate in order left to right
			if Player1Table.get_child(CardPosition).get_child(0).get_child_count() != 0:
				SelectedCard = Player1Table.get_child(CardPosition).get_child(0).get_child(0)
				#print("Card ", CardPosition + 1, " of P1 activates")
				SelectedCard.activate(CardPosition, 1)
				await get_tree().create_timer(0.5).timeout
	
		fill_mana(2, ManaGainAmount)	# Player 2 gets their mana and cards
		await get_tree().create_timer(0.25).timeout
		deal_cards_to_player(2, CardGainAmount)
		await get_tree().create_timer(0.5).timeout
		
		player2_play_random_card()		# Player 2 makes moves
		if 0.75 > randf():
			player2_play_random_card()
			if 0.5 > randf():
				player2_play_random_card()
				if 0.25 > randf():
					player2_play_random_card()
		await get_tree().create_timer(0.25).timeout
	
		for CardPosition in 4:			# Player 2 cards activate
			if Player2Table.get_child(CardPosition).get_child(0).get_child_count() != 0:
				SelectedCard = Player2Table.get_child(CardPosition).get_child(0).get_child(0)
				SelectedCard.activate(CardPosition, 2)
				await get_tree().create_timer(0.5).timeout
	
		match Turn:						# After X turns, start giving one more card
			3:
				CardGainAmount += 1
			5:
				CardGainAmount += 1
	
		deal_cards_to_player(1, CardGainAmount)			# Player 1 gets their mana and cards
		await get_tree().create_timer(0.25).timeout
		fill_mana(1, ManaGainAmount)
	
		if ManaGainAmount < 5:
			ManaGainAmount += 1
		await get_tree().create_timer(0.25).timeout
		Turn += 1
		TurnCountLabel.set_text(str("Turn: ", Turn))
		CardFunctions.turn_passed()
		AbleToPlay = true
	else:
		$DenySound.play()

func fill_mana(Player, ManaGain):
	if Player == 1 or 0:
		P1Mana += ManaGain
		if P1Mana > 5:
			P1Mana = 5
		P1ManaBar.update_label(P1Mana)
	elif Player == 2 or 0:
		P2Mana += ManaGain
		if P2Mana > 5:
			P2Mana = 5
		P2ManaBar.update_label(P2Mana)
