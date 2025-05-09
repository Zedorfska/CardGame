extends "res://Cards/card_functions.gd"

var CostAmount = 2
var CardType = "Effect"

var SCPNumber = "207"
var CardName = "Bottle"
var Description = "Enhances a card, but starts damaging it over time."
var ContainmentClass = "Safe"

func _ready():
	add_label(self, "Cost")

func activate(_CardPosition, _Player):
	pass
