extends "res://Cards/card_functions.gd"

var MaxHealth = 2
var HealthAmount = MaxHealth
var DamageAmount = 2
var CostAmount = 0
var DamageType = "Basic"
var Playtype = "Unit"

var SCPNumber = "049-2"
var CardName = "The Cured"
var Description = "A corpse reanimated by SCP-049."
var ContainmentClass = "Euclid"

@onready var StatusEffects = $Effects

func _ready():
	add_label(self, "Damage", 0)
	add_label(self, "Health", 1)
	add_label(self, "Cost", 2)

func activate(CardPosition, Player):
	basic_common_attack(CardPosition, DamageAmount, DamageType, Player, self)
	await get_tree().create_timer(AsyncActivateToTriggerStatusEffects).timeout
	trigger_status_effects(self)

func take_damage(Damage, _DamageType):
	take_damage_basic(self, Damage, _DamageType)

func destroyed():
	pass
