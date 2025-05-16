extends "res://Cards/card_functions.gd"

var Stage: int = 0

var MaxHealth: int = 2
var HealthAmount: int = MaxHealth
var DamageAmount: int = 1
var CostAmount: int = 1
var DamageType: String = "Basic"
var CardType: String = "Unit"

var SCPNumber: String = "682"
var CardName: String = "The Hard-To-Kill Lizard"
var Description: String = "A lizard regenerating itself at incredible speeds."
var ContainmentClass: String = "Keter"

@onready var StatusEffects = $Effects

func _ready():
	add_label(self, "Damage")
	add_label(self, "Health")
	add_label(self, "Cost")

func activate(CardPosition, Player):
	basic_common_attack(CardPosition, DamageAmount, DamageType, Player, self)
	
	await get_tree().create_timer(AsyncActivateToTriggerStatusEffects).timeout
	trigger_status_effects(self)

func destroy():
	Stage += 1
	if Stage == 5:
		super.destroy()
	else:
		MaxHealth += 1
		HealthAmount = MaxHealth
		HealthLabel.update_label()
		DamageAmount += 1
		DamageLabel.update_label()
		CostAmount += 1
		CostLabel.update_label()
		for i in range(MainNode.Player1Hand.get_child_count()):
			if MainNode.Player1Hand.get_child(i).get_child(0).get_child_count() == 0:
				self.reparent(MainNode.Player1Hand.get_child(i).get_child(0), true)
				var tween = get_tree().create_tween()
				tween.tween_property(self, "position", Vector2.ZERO, 0.25)
