extends "res://Cards/card_functions.gd"

var CostAmount: int = 3
var CardType: String = "Effect"

var SCPNumber: String = "500"
var CardName: String = "The Panacea"
var Description: String = "Fully heals a card and removes all status effects."
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
		ParentCard.HealthAmount = ParentCard.MaxHealth
		ParentCard.HealthLabel.update_label()
	ParentCard.clear_status_effect("All")
	self.scale = Vector2(0.27,  0.27)
	rotation_shake_animation(self)

func activate():
	pass
