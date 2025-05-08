extends "res://Cards/card_functions.gd"

var CostAmount = 2
var DamageType = "InstaKill"
var Playtype = "Effect"

var SCPNumber = "207"
var CardName = "Bottle"
var Description = "Enhances a card, but starts damaging it over time."
var ContainmentClass = "Safe"

func _ready():
	add_label(self, "Cost")

func played(GotPosition, GotOwner):
	update_self_position(GotPosition)
	update_self_owner(GotOwner)

func activate(_CardPosition, _Player):
	pass

func take_damage(_Damage, _DamageTakenType):
	pass

func destroy():
	self.queue_free()
