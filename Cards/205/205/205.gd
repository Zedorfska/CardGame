extends "res://Cards/card_functions.gd"

var TweenCard

var SCP205_1 = preload("res://Cards/205/205-1/205_1.tscn")

var MaxHealth: int = 2
var HealthAmount: int = MaxHealth
var DamageAmount: int = 0
var CostAmount: int = 3
var DamageType: String = "Basic"
var Playtype: String = "Unit"

var SCPNumber: String = "205"
var CardName: String = "The Shadow Lamps"
var Description: String = "Anomalous floodlight that summons two living shadows next to it."
var ContainmentClass: String = "Euclid"

@onready var StatusEffects = $Effects

func _ready():
	add_label(self, "Health", 0)
	add_label(self, "Cost", 1)

func activate(CardPosition, Player):
	glow_animation(self)
	
	if Player == 1:
		ChildToGet = 2
	else:
		ChildToGet = 1
	if CardPosition != 0 and Table.get_child(ChildToGet).get_child(CardPosition - 1).get_child(0).get_child_count() == 0:
		Table.get_child(ChildToGet).get_child(CardPosition - 1).get_child(0).add_child(SCP205_1.instantiate())
		TweenCard = Table.get_child(ChildToGet).get_child(CardPosition - 1).get_child(0).get_child(0)
		TweenCard.global_position = self.global_position
		var TweenCard205Move = get_tree().create_tween()
		TweenCard205Move.tween_property(TweenCard, "position", Vector2.ZERO, 0.25)
	if CardPosition != 3 and Table.get_child(ChildToGet).get_child(CardPosition + 1).get_child(0).get_child_count() == 0:
		Table.get_child(ChildToGet).get_child(CardPosition + 1).get_child(0).add_child(SCP205_1.instantiate())
		TweenCard = Table.get_child(ChildToGet).get_child(CardPosition + 1).get_child(0).get_child(0)
		TweenCard.global_position = self.global_position
		var TweenCard205Move = get_tree().create_tween()
		TweenCard205Move.tween_property(TweenCard, "position", Vector2.ZERO, 0.25)
		Table.get_child(ChildToGet).get_child(CardPosition + 1).get_child(0).get_child(0).SpawnDelayCanAttack = false
	
	await get_tree().create_timer(AsyncActivateToTriggerStatusEffects).timeout
	trigger_status_effects(self)

func take_damage(Damage, _DamageType):
	take_damage_basic(self, Damage, _DamageType)

func destroyed():
	pass
