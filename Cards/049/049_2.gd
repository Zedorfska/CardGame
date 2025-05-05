extends "res://Cards/card_functions.gd"

var SCPNumberScene = preload("res://Root/Labels/number_label.tscn")
var HealthLabelScene = preload("res://Root/Labels/health_label.tscn")
var DamageLabelScene = preload("res://Root/Labels/damage_label.tscn")
var CostLabelScene = preload("res://Root/Labels/cost_label.tscn")
var SCPNumberLabel
var HealthLabel
var DamageLabel
var CostLabel

var MaxHealth = 2
var HealthAmount = MaxHealth
var DamageAmount = 2
var CostAmount = 0
var DamageType = "Basic"
var Playtype = "Unit"

@onready var SCPNumber = "049-2"
@onready var CardName = "The Cured"
@onready var Description = "A corpse reanimated by SCP-049."
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
	RootNode.basic_common_attack(CardPosition, DamageAmount, DamageType, Player, self)
	await get_tree().create_timer(AsyncActivateToTriggerStatusEffects).timeout
	trigger_status_effects(self)

func take_damage(Damage, _DamageType):
	HealthAmount -= Damage
	print("Card \"", CardName, "\" took ", Damage, " damage.")
	if HealthAmount <= 0:
		print("Card destroyed!")
		self.queue_free()
	HealthLabel.update_label(HealthAmount, ContainmentClass)
