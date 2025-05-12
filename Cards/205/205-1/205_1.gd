extends "res://Cards/card_functions.gd"

var SpawnDelayCanAttack = true

var MaxHealth: int = 1
var HealthAmount: int = MaxHealth
var DamageAmount: int = 2
var CostAmount: int = 0
var DamageType: String = "Basic"
var CardType: String = "Unit"

var SCPNumber: String = "205-1"
var CardName: String = "Living Shadow"
var Description: String = "A shadow cast by SCP-205. Due to not physically existing, this card cannot be attacked."
var ContainmentClass: String = "Euclid"

@onready var StatusEffects = $Effects

func _ready():
	add_label(self, "Damage")

func activate(CardPosition, Player):
	if SpawnDelayCanAttack == true:
		basic_common_attack(CardPosition, DamageAmount, DamageType, Player, self)
		await get_tree().create_timer(AsyncActivateToTriggerStatusEffects).timeout
		trigger_status_effects(self)
	else:
		SpawnDelayCanAttack = true

func destroy():
	PassDamage = true
	var tween = get_tree().create_tween()
	tween.tween_property(self, "modulate:a", 0, 1)
	await get_tree().create_timer(1).timeout
	super.destroy()

func take_damage(_Damage, _DamageTakenType):
	evaded_attack_animation(self)
