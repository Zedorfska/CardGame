extends "res://Cards/card_functions.gd"

var MaxHealth = 5
var HealthAmount = MaxHealth
var DamageAmount = 2
var CostAmount = 1
var DamageType = "Basic"
var Playtype = "Unit"

var SCPNumber = "000"
var CardName = "TestCard"
var Description = "Yo"
var ContainmentClass = "Safe"

@onready var StatusEffects = $Effects

func _ready():
	add_label(self, "Damage")
	add_label(self, "Health")
	add_label(self, "Cost")

func played(GotPosition, GotOwner):
	update_self_position(GotPosition)
	update_self_owner(GotOwner)

func activate(CardPosition, Player):
	basic_common_attack(CardPosition, DamageAmount, DamageType, Player, self)

func take_damage(Damage, DamageTakenType):
	take_damage_basic(self, Damage, DamageTakenType)

func destroy():
	self.queue_free()
