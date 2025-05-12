extends "res://Cards/card_functions.gd"

var AmountOfTimesTriggered: int = 0

var CostAmount: int = 2
var CardType: String = "Effect"

var SCPNumber: String = "207"
var CardName: String = "Bottle"
var Description: String = "Enhances a card, but starts damaging it over time."
var ContainmentClass: String = "Safe"

func _ready():	#TODO: next
	add_label(self, "Cost")

func activate(_CardPosition, _Player):
	ParentCard.take_damage(1, "Basic")
	print(ParentCard, " has 207")
	ParentCard.DamageAmount += 1
	AmountOfTimesTriggered += 1

func destroy():
	ParentCard.DamageAmount -= AmountOfTimesTriggered
	super.destroy()
