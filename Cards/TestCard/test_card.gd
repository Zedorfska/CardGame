extends Node2D

var SCPNumberScene = preload("res://Root/Labels/number_label.tscn")
var HealthLabelScene = preload("res://Root/Labels/health_label.tscn")
var DamageLabelScene = preload("res://Root/Labels/damage_label.tscn")
var CostLabelScene = preload("res://Root/Labels/cost_label.tscn")
var SCPNumberLabel
var HealthLabel
var DamageLabel
var CostLabel

var MaxHealth = 5
var HealthAmount = MaxHealth
var DamageAmount = 2
var CostAmount = 1
var DamageType = "Basic"

@onready var SCPNumber = "000"
@onready var CardName = "TestCard"
@onready var Description = "Yo"
@onready var ContainmentClass = "Safe"

func _ready():
	self.add_child(DamageLabelScene.instantiate())
	DamageLabel = self.get_child(1)
	DamageLabel.update_label(DamageAmount, ContainmentClass)
	
	self.add_child(HealthLabelScene.instantiate())
	HealthLabel = self.get_child(2)
	HealthLabel.update_label(HealthAmount, ContainmentClass)
	
	self.add_child(CostLabelScene.instantiate())
	CostLabel = self.get_child(3)
	CostLabel.update_label(CostAmount)

func activate(RootNode, CardPosition, Player):
	RootNode.basic_common_attack(CardPosition, DamageAmount, DamageType, Player, self)

func take_damage(Damage, _DamageType):
	HealthAmount -= Damage
	print("Card took ", Damage, " damage.")
	if HealthAmount <= 0:
		print("Card destroyed!")
		self.queue_free()
	HealthLabel.update_label(HealthAmount, ContainmentClass)
