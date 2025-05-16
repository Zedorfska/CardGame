extends "res://Cards/card_functions.gd"

var DamageAmount: int = 3
var CostAmount: int = 2
var CardType: String = "Spell"

var SCPNumber: String = "018"
var CardName: String = "Ball"
var Description: String = "A physics-defying bouncy ball that gains energy when bouncing, rather than losing it.\nWhen played it damages 3 random cards for 3 points." #TODO - this can change but for some reason I cant fucking make it read the var
var ContainmentClass: String = "Euclid"

func _ready():
	add_label(self, "Cost")
	CostLabel.position.y = 15

func played(_Card, _GotPosition, _GotOwner):
	MainNode.AbleToPlay = false
	var tween = get_tree().create_tween()
	tween.tween_property(self, "scale", Vector2(1.5,  1.5), 0.1)
	var ListOfCardsOnTable = []
	for i in 4:
		if MainNode.Player1Table.get_child(i).get_child(0).get_child_count() != 0:
			ListOfCardsOnTable.append(MainNode.Player1Table.get_child(i).get_child(0).get_child(0))
		if MainNode.Player2Table.get_child(i).get_child(0).get_child_count() != 0:
			ListOfCardsOnTable.append(MainNode.Player2Table.get_child(i).get_child(0).get_child(0))
	
	await get_tree().create_timer(0.5).timeout
	
	for i in 3:
		rotation_shake_animation(self)
		var RandomCard = null
		if ListOfCardsOnTable.size() > 0:
			RandomCard = ListOfCardsOnTable.pick_random()
			if RandomCard != null:
				await cant_activate_animation(RandomCard)
				await RandomCard.take_damage(DamageAmount, "Basic")
				if is_instance_valid(RandomCard) == false:
					ListOfCardsOnTable.erase(RandomCard)
		await get_tree().create_timer(0.5).timeout
	
	await fade_out_animation(self, 0.5)
	self.destroy()
	MainNode.AbleToPlay = false
