extends "res://Cards/card_functions.gd"

var State = "Stalk"

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

func set_state(GotState):
	match GotState:
		"Stalk":
			State = "Stalk"
			PassDamage = true
			var tween = get_tree().create_tween()
			tween.tween_property(self, "modulate:a", 0.5, 0.25)
		"Active":
			State = "Active"
			PassDamage = false
			var tween = get_tree().create_tween()
			tween.tween_property(self, "modulate:a", 1, 0.1)

func _ready():
	PassDamage = true
	add_label(self, "Damage")
	add_label(self, "Health")
	add_label(self, "Cost")

func played(Card, GotOwner, GotPosition):
	super.played(Card, GotOwner, GotPosition)
	await get_tree().create_timer(0.25).timeout
	set_state("Stalk")

func activate(CardPosition, Player):	#TODO: invisible and reduces opposing cards attack, after stalk attacks
	ChildToGet = 1
	if SelfOwner == 2:
		ChildToGet = 2
	if Table.get_child(ChildToGet).get_child(SelfPosition).get_child(0).get_child_count() != 0:
		var CardToBeAttacked = Table.get_child(ChildToGet).get_child(SelfPosition).get_child(0).get_child(0)
		if "DamageAmount" in CardToBeAttacked:
			if CardToBeAttacked.DamageAmount > 0 and State == "Stalk":
				drain_damage_attack(CardPosition, DamageAmount, DamageType, Player, self)
			else:
				set_state("Active")
				basic_common_attack(CardPosition, DamageAmount, DamageType, Player, self)
		else:
			set_state("Active")
			basic_common_attack(CardPosition, DamageAmount, DamageType, Player, self)
	else:
		set_state("Stalk")
		basic_common_attack(CardPosition, DamageAmount, DamageType, Player, self)
	
	await get_tree().create_timer(AsyncActivateToTriggerStatusEffects).timeout
	trigger_status_effects(self)
