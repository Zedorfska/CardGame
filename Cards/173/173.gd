extends "res://Cards/card_functions.gd"

var SCPNumberScene = preload("res://Root/Labels/number_label.tscn")
var HealthLabelScene = preload("res://Root/Labels/health_label.tscn")
var DamageLabelScene = preload("res://Root/Labels/damage_label.tscn")
var CostLabelScene = preload("res://Root/Labels/cost_label.tscn")
var SCPNumberLabel
var HealthLabel
var DamageLabel
var CostLabel

var MaxHealth = 8
var HealthAmount = MaxHealth
var DamageAmount = 7
var CostAmount = 3
var DamageType = "Basic"
var Playtype = "Unit"

var TurnPlayedOn
var HighestAmountOfCards

@onready var SCPNumber = "173"
@onready var CardName = "The Sculpture"
@onready var Description = "SCP-173 can only move while unobserved:\nThis card takes longer to attack the more cards are on the table."
@onready var ContainmentClass = "Euclid"

@onready var StatusEffects = $Effects

func _ready():
	self.add_child(DamageLabelScene.instantiate())
	DamageLabel = self.get_child(2)
	DamageLabel.update_label(DamageAmount, ContainmentClass)
	
	self.add_child(HealthLabelScene.instantiate())
	HealthLabel = self.get_child(3)
	HealthLabel.update_label(HealthAmount, ContainmentClass)
	
	self.add_child(CostLabelScene.instantiate())
	CostLabel = self.get_child(4)
	CostLabel.update_label(CostAmount)

func activate(RootNode, CardPosition, Player):
	if TurnPlayedOn == null:
		TurnPlayedOn = get_tree().root.get_child(0).get_child(0).Turn
	var Turn = get_tree().root.get_child(0).get_child(0).Turn
	var AmountOfCards = get_tree().root.get_child(0).get_child(0).get_amount_of_active_cards()
	var AmountOfTurnsExisted = Turn - TurnPlayedOn
	Description = str("SCP-173 can only move while unobserved:\nThis card takes longer to attack the more cards are on the table.\nIt will attack in ", AmountOfCards - AmountOfTurnsExisted, " turns.")
	if Turn - TurnPlayedOn >= AmountOfCards:
		RootNode.basic_common_attack(CardPosition, DamageAmount, DamageType, Player, self)
		TurnPlayedOn = null
	else:
		cant_activate_animation(self)
	await get_tree().create_timer(AsyncActivateToTriggerStatusEffects).timeout
	trigger_status_effects(self)

func take_damage(Damage, _DamageType):
	HealthAmount -= Damage
	print("Card \"", CardName, "\" took ", Damage, " damage.")
	if HealthAmount <= 0:
		print("Card destroyed!")
		self.queue_free()
	HealthLabel.update_label(HealthAmount, ContainmentClass)
