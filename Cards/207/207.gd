extends "res://Cards/card_functions.gd"

var AmountOfTimesTriggered: int = 0

var CostAmount: int = 2
var CardType: String = "Effect"

var SCPNumber: String = "207"
var CardName: String = "Bottle"
var Description: String = "Enhances a card, but starts damaging it over time."
var ContainmentClass: String = "Safe"

func _ready():
	add_label(self, "Cost")
	CostLabel.position.y = 15

func played(Card, GotPosition, GotOwner):
	await get_tree().create_timer(0.25).timeout
	var tween1 = get_tree().create_tween()
	tween1.tween_property(self, "scale", Vector2(0.25,  0.25), 0.1)
	var tween2 = get_tree().create_tween()
	tween2.tween_property(self, "position", Vector2(0, 60), 0.1)
	super.played(Card, GotPosition, GotOwner)

func activate():
	self.scale = Vector2(0.27,  0.27)
	rotation_shake_animation(self)
	await get_tree().create_timer(0.25).timeout
	var tween1 = get_tree().create_tween()
	tween1.tween_property(self, "scale", Vector2(0.25,  0.25), 0.1)
	if "HealthAmount" in ParentCard:
		ParentCard.take_damage(1, "Basic")
	if "DamageAmount" in ParentCard:
		ParentCard.DamageAmount += 1
		ParentCard.DamageLabel.update_label(ParentCard.DamageAmount, ParentCard.ContainmentClass)
	AmountOfTimesTriggered += 1

func destroy():
	if "DamageAmount" in ParentCard:
		ParentCard.DamageAmount -= AmountOfTimesTriggered
	super.destroy()
