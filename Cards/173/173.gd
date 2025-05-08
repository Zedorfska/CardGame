extends "res://Cards/card_functions.gd"

var MaxHealth = 8
var HealthAmount = MaxHealth
var DamageAmount = 7
var CostAmount = 3
var DamageType = "Basic"
var Playtype = "Unit"

var SCPNumber = "173"
var CardName = "The Sculpture"
static var Description = "SCP-173 can only move while unobserved:\nThis card takes longer to attack the more cards are on the table."
var ContainmentClass = "Euclid"

@onready var StatusEffects = $Effects

static var AmountOfCards
static var TurnPlayedOn
static var CurrentTurn
static var TurnsToAttackLabel

func _ready():
	add_label(self, "Damage")
	add_label(self, "Health")
	add_label(self, "Cost")
	TurnsToAttackLabel = $TurnsToAttackLabel

func played(GotPosition, GotOwner):
	TurnPlayedOn = MainNode.Turn
	amount_of_cards_on_table_changed()
	update_self_position(GotPosition)
	update_self_owner(GotOwner)

func activate(CardPosition, Player):
	AmountOfCards = MainNode.get_amount_of_active_cards()
	CurrentTurn = MainNode.Turn
	if CurrentTurn - TurnPlayedOn >= AmountOfCards:
		basic_common_attack(CardPosition, DamageAmount, DamageType, Player, self)
		TurnPlayedOn = null
	else:
		cant_activate_animation(self)
	
	await get_tree().create_timer(AsyncActivateToTriggerStatusEffects).timeout
	trigger_status_effects(self)

func take_damage(Damage, DamageTakenType):
	take_damage_basic(self, Damage, DamageTakenType)

func destroy():
	amount_of_cards_on_table_changed()
	self.queue_free()

static func update_turns_to_attack_number():
	CurrentTurn = MainNode.Turn
	AmountOfCards = MainNode.get_amount_of_active_cards()
	var AmountOfTurnsExisted = CurrentTurn - TurnPlayedOn
	var TurnsToAttack = AmountOfCards - AmountOfTurnsExisted
	TurnsToAttackLabel.set_text(str(TurnsToAttack))
	Description = str("SCP-173 can only move while unobserved:\nThis card takes longer to attack the more cards are on the table.\nIt will attack in ", TurnsToAttack, " turns.")
