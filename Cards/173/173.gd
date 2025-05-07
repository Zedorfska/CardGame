extends "res://Cards/card_functions.gd"

var MaxHealth = 8
var HealthAmount = MaxHealth
var DamageAmount = 7
var CostAmount = 3
var DamageType = "Basic"
var Playtype = "Unit"

var SCPNumber = "173"
var CardName = "The Sculpture"
var Description = "SCP-173 can only move while unobserved:\nThis card takes longer to attack the more cards are on the table."
var ContainmentClass = "Euclid"

@onready var StatusEffects = $Effects

var TurnPlayedOn
var HighestAmountOfCards

func _ready():
	add_label(self, "Damage", 0)
	add_label(self, "Health", 1)
	add_label(self, "Cost", 2)

func played(GotPosition, GotOwner):
	update_self_position(GotPosition)
	update_self_owner(GotOwner)

func activate(CardPosition, Player):
	if TurnPlayedOn == null:
		TurnPlayedOn = get_tree().root.get_child(0).get_child(0).Turn
	var Turn = get_tree().root.get_child(0).get_child(0).Turn
	var AmountOfCards = get_tree().root.get_child(0).get_child(0).get_amount_of_active_cards()
	var AmountOfTurnsExisted = Turn - TurnPlayedOn
	Description = str("SCP-173 can only move while unobserved:\nThis card takes longer to attack the more cards are on the table.\nIt will attack in ", AmountOfCards - AmountOfTurnsExisted, " turns.")
	if Turn - TurnPlayedOn >= AmountOfCards:
		basic_common_attack(CardPosition, DamageAmount, DamageType, Player, self)
		TurnPlayedOn = null
	else:
		cant_activate_animation(self)
	await get_tree().create_timer(AsyncActivateToTriggerStatusEffects).timeout
	trigger_status_effects(self)

func take_damage(Damage, DamageTakenType):
	take_damage_basic(self, Damage, DamageTakenType)

func destroy():
	self.queue_free()
