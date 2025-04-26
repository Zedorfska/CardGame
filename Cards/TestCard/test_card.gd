extends Node2D

var HealthLabelScene = preload("res://Root/Labels/health_label.tscn")
var DamageLabelScene = preload("res://Root/Labels/damage_label.tscn")
var HealthLabel
var DamageLabel

var MaxHealth = 5
var HealthAmount = 5
var DamageAmount = 2
var DamageType = 0

func _ready():
	self.add_child(HealthLabelScene.instantiate())
	HealthLabel = self.get_child(1)
	HealthLabel.update_label(HealthAmount)
	
	self.add_child(DamageLabelScene.instantiate())
	DamageLabel = self.get_child(2)
	DamageLabel.update_label(DamageAmount)

func activate(RootNode, CardPosition, Player):
	RootNode.basic_common_attack(CardPosition, DamageAmount, DamageType, Player)

func take_damage(Damage, _DamageType):
	HealthAmount -= Damage
	print("Card took ", Damage, " damage.")
	if HealthAmount <= 0:
		print("Card destroyed!")
		self.queue_free()
	HealthLabel.update_label(HealthAmount)
