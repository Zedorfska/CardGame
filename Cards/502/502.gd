extends "res://Cards/card_functions.gd"

var CostAmount: int = 2
var CardType: String = "Effect"

var SCPNumber: String = "502"
var CardName: String = "The Cardboard Organ"
var Description: String = "Effect: If applied to a card with full heatlh, increases its damage by 2 points, else heals that card for 2 points."
var ContainmentClass: String = "Safe"

func _ready():
	add_label(self, "Cost")
	CostLabel.position.y = 15

func played(Card, GotPosition, GotOwner):
	var tween1 = get_tree().create_tween()
	tween1.tween_property(self, "scale", Vector2(0.25,  0.25), 0.1)
	super.played(Card, GotPosition, GotOwner)
	await get_tree().create_timer(0.25).timeout
	if "HealthAmount" in ParentCard:
		if ParentCard.HealthAmount >= ParentCard.MaxHealth and "DamageAmount" in ParentCard:
			rotation_shake_animation(self)
			ParentCard.DamageAmount += 2
			ParentCard.DamageLabel.update_label()
		else:
			rotation_shake_animation(self)
			if ParentCard.HealthAmount + 2 > ParentCard.MaxHealth:
				ParentCard.HealthAmount = ParentCard.MaxHealth
			else:
				ParentCard.HealthAmount += 2
			ParentCard.HealthLabel.update_label()
			return
	elif "DamageAmount" in ParentCard:
		rotation_shake_animation(self)
		ParentCard.DamageAmount += 2
		ParentCard.DamageLabel.update_label()

func activate():
	pass
