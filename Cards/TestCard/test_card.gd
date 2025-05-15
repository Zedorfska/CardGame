extends "res://Cards/card_functions.gd"

var MaxHealth = 5
var HealthAmount = MaxHealth
var DamageAmount = 2
var CostAmount = 1
var DamageType = "Basic"
var CardType = "Unit"

var SCPNumber = "000"
var CardName = "TestCard"
var Description = "holy crap."
var ContainmentClass = "Safe"

@onready var StatusEffects = $Effects

func _ready():
	add_label(self, "Damage")
	add_label(self, "Health")
	add_label(self, "Cost")

func activate(CardPosition, Player):
	basic_common_attack(CardPosition, DamageAmount, DamageType, Player, self)
	
	await get_tree().create_timer(AsyncActivateToTriggerStatusEffects).timeout
	trigger_status_effects(self)
