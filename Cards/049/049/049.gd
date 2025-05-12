extends "res://Cards/card_functions.gd"

var EnemyExistsPreAttack
var EnemyExistsPostAttack

var SCP049_2 = preload("res://Cards/049/049-2/049_2.tscn")

var MaxHealth: int = 2
var HealthAmount: int = MaxHealth
var DamageAmount: int = 1
var CostAmount: int = 2
var DamageType: String = "InstaKill"
var CardType = "Unit"

var SCPNumber = "049"
var CardName = "The Plague Doctor"
var Description = "This card instantly destroys the opposing card.\nWhenever this card destroys an opposing card:\n    One 049-2 is added to your hand."
var ContainmentClass = "Euclid"

@onready var StatusEffects = $Effects

func _ready():
	add_label(self, "Damage")
	add_label(self, "Health")
	add_label(self, "Cost")

func activate(CardPosition, Player):
	if Table.get_child(Player).get_child(CardPosition).get_child(0).get_child_count() != 0:
		EnemyExistsPreAttack = true
	else:
		EnemyExistsPreAttack = false
	
	await basic_common_attack(CardPosition, DamageAmount, DamageType, Player, self)
	await get_tree().create_timer(0.1).timeout #TODO: needed rn due to queue_free() on the card being destroyed
	
	if Table.get_child(Player).get_child(CardPosition).get_child(0).get_child_count() == 0:
		EnemyExistsPostAttack = false
	else:
		EnemyExistsPostAttack = true
	
	if EnemyExistsPreAttack == true and EnemyExistsPostAttack == false:
		ChildToGet = 3
		if Player == 2:
			ChildToGet = 0
		for HandToBeDealtTo in 6:
			if Table.get_child(ChildToGet).get_child(HandToBeDealtTo).get_child(0).get_child_count() == 0:
				Table.get_child(ChildToGet).get_child(HandToBeDealtTo).get_child(0).add_child(SCP049_2.instantiate())
				var TweenCard = Table.get_child(ChildToGet).get_child(HandToBeDealtTo).get_child(0).get_child(0)
				TweenCard.global_position = Table.get_child(Player).get_child(CardPosition).get_child(0).global_position
				TweenCard.modulate.a = 0
				await get_tree().create_timer(0.25).timeout
				var TweenCard049Alpha = get_tree().create_tween()
				TweenCard049Alpha.tween_property(TweenCard, "modulate:a", 1, 0.25)
				await get_tree().create_timer(0.5).timeout
				var TweenCard049Move = get_tree().create_tween()
				TweenCard049Move.tween_property(TweenCard, "position", Vector2.ZERO, 0.25)
				break
	
	await get_tree().create_timer(AsyncActivateToTriggerStatusEffects).timeout
	trigger_status_effects(self)
