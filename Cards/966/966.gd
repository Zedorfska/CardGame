extends "res://Cards/card_functions.gd"

var MaxHealth: int = 1
var HealthAmount: int = MaxHealth
var DamageAmount: int = 2
var CostAmount: int = 2
var DamageType: String = "Basic"
var CardType: String = "Unit"

var SCPNumber: String = "966"
var CardName: String = "The Insomnia Hunter"
var Description: String = "A stalking predator inflicting their victim with insomnia.\nThis card stalks"
var ContainmentClass: String = "Euclid"

@onready var StatusEffects = $Effects

func _ready():
	PassDamage = true
	add_label(self, "Damage")
	add_label(self, "Health")
	add_label(self, "Cost")

func activate(CardPosition, Player):	#TODO: invisible and reduces opposing cards attack, after stalk attacks
	basic_common_attack(CardPosition, DamageAmount, DamageType, Player, self)
	
	await get_tree().create_timer(AsyncActivateToTriggerStatusEffects).timeout
	trigger_status_effects(self)
