extends "res://Cards/card_functions.gd"

var SCP173SpriteDefault = load(str(CardsPath, "173/173.svg"))
var SCP173SpriteLightsOut = load(str(CardsPath, "173/173LightsOut.svg"))

var SpriteDefault = CardsPath
var SpriteLightsOut = CardsPath

var TurnsToAttackLabelOpacity

var MaxHealth: int = 8
var HealthAmount: int = MaxHealth
var DamageAmount: int = 7
var CostAmount: int = 3
var DamageType: String = "Basic"
var CardType: String = "Unit"

var SCPNumber: String = "173"
var CardName: String = "The Sculpture"
var Description: String = "SCP-173 can only move while unobserved:\nThis card takes longer to attack the more cards are on the table."
var ContainmentClass: String = "Euclid"

@onready var StatusEffects = $Effects

var AmountOfCards
var TurnLastActivate
var CurrentTurn
var TurnsToAttackLabel

func _ready():
	add_label(self, "Damage")
	add_label(self, "Health")
	add_label(self, "Cost")
	TurnsToAttackLabel = $TurnsToAttackLabel
	SignalManager.amount_of_cards_on_table_changed_signal.connect(update_turns_to_attack_number)

func played(Card, GotPosition, GotOwner):
	super.played(Card, GotPosition, GotOwner)
	TurnLastActivate = TurnPlayedOn
	update_turns_to_attack_number()

func activate(CardPosition, Player):
	AmountOfCards = MainNode.get_amount_of_active_cards()
	CurrentTurn = MainNode.Turn
	if CurrentTurn - TurnLastActivate >= AmountOfCards:
		TurnLastActivate = MainNode.Turn
		basic_common_attack(CardPosition, DamageAmount, DamageType, Player, self)
		await get_tree().create_timer(0.15).timeout
	update_turns_to_attack_number()
	cant_activate_animation(self)
	
	await get_tree().create_timer(AsyncActivateToTriggerStatusEffects).timeout
	trigger_status_effects(self)

func update_turns_to_attack_number():	#TODO: Make attack inevitable when TurnsToAttack == 0
	if TurnLastActivate != null:		#TODO: 205 does not activate the function correctly
		CurrentTurn = MainNode.Turn
		AmountOfCards = MainNode.get_amount_of_active_cards()
		var AmountOfTurnsExisted = CurrentTurn - TurnLastActivate
		var TurnsToAttack = AmountOfCards - AmountOfTurnsExisted - 1
		if TurnsToAttack <= 0:
			$"173Sprite".set_texture(SCP173SpriteLightsOut)
		else:
			$"173Sprite".set_texture(SCP173SpriteDefault)
			TurnsToAttackLabel.set_text(str(TurnsToAttack))
			TurnsToAttackLabel.modulate.a = 1
			if TurnsToAttackLabelOpacity != null:
				TurnsToAttackLabelOpacity.stop()
			TurnsToAttackLabelOpacity = get_tree().create_tween()
			TurnsToAttackLabelOpacity.tween_property(TurnsToAttackLabel, "modulate:a", 0, 1)
		Description = str("SCP-173 can only move while unobserved:\nThis card takes longer to attack the more cards are on the table.\nIt will attack in ", TurnsToAttack, " turns.")

func destroy():
	TurnsToAttackLabelOpacity.stop()
	super.destroy()
