extends "res://Cards/card_functions.gd"

var SpawnDelayCanAttack = true

var MaxHealth = 1
var HealthAmount = MaxHealth
var DamageAmount = 2
var CostAmount = 0
var DamageType = "Basic"
var Playtype = "Unit"

var SCPNumber = "205-1"
var CardName = "Shadow Puppet"
var Description = "A shadow cast by SCP-205. Due to not physically existing, this card cannot be attacked."
var ContainmentClass = "Euclid"

@onready var StatusEffects = $Effects

func _ready():
	add_label(self, "Damage", 0)

func played(GotPosition, GotOwner):
	update_self_position(GotPosition)
	update_self_owner(GotOwner)

func activate(CardPosition, Player):
	if SpawnDelayCanAttack == true:
		basic_common_attack(CardPosition, DamageAmount, DamageType, Player, self)
		await get_tree().create_timer(AsyncActivateToTriggerStatusEffects).timeout
		trigger_status_effects(self)
	else:
		SpawnDelayCanAttack = true

func fade_out():
	var tween = get_tree().create_tween()
	tween.tween_property(self, "modulate:a", 0, 1)
	await get_tree().create_timer(1.1).timeout
	self.destroy()

func take_damage(_Damage, _DamageTakenType):
	evaded_attack_animation(self)
	pass

func destroy():
	self.queue_free()
