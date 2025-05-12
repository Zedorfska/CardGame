extends "res://Cards/card_functions.gd"

var MaxHealth: int = 2
var HealthAmount: int = MaxHealth
var DamageAmount: int = 2
var CostAmount: int = 0
var DamageType: String = "Basic"
var CardType: String = "Unit"

var SCPNumber: String = "049-2"
var CardName: String = "The Cured"
var Description: String = "A corpse reanimated by SCP-049."
var ContainmentClass: String = "Euclid"

@onready var StatusEffects = $Effects

func _ready():
	add_label(self, "Damage")
	add_label(self, "Health")
	add_label(self, "Cost")

func activate(CardPosition, Player):
	basic_common_attack(CardPosition, DamageAmount, DamageType, Player, self)
	
	await get_tree().create_timer(AsyncActivateToTriggerStatusEffects).timeout
	trigger_status_effects(self)
