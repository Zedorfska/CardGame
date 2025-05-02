extends Node2D

var SCPNumberScene = preload("res://Root/Labels/number_label.tscn")
var HealthLabelScene = preload("res://Root/Labels/health_label.tscn")
var DamageLabelScene = preload("res://Root/Labels/damage_label.tscn")
var CostLabelScene = preload("res://Root/Labels/cost_label.tscn")
var SCPNumberLabel
var HealthLabel
var DamageLabel
var CostLabel

var MaxHealth = 2
var HealthAmount = MaxHealth
var DamageAmount = 1
var CostAmount = 1
var DamageType = "Instant"

@onready var SCPNumber = "049"
@onready var CardName = "The Plague Doctor"
@onready var Description = "This card instantly destroys the opposing card.\nWhenever this card destroys an opposing card:\n    One 049-2 is added to your hand."
@onready var ContainmentClass = "Euclid"

func _ready():
	self.add_child(SCPNumberScene.instantiate())
	SCPNumberLabel = self.get_child(1)
	SCPNumberLabel.update_label(SCPNumber, ContainmentClass)
	
	self.add_child(DamageLabelScene.instantiate())
	DamageLabel = self.get_child(2)
	DamageLabel.update_label(DamageAmount, ContainmentClass)
	
	self.add_child(HealthLabelScene.instantiate())
	HealthLabel = self.get_child(3)
	HealthLabel.update_label(HealthAmount, ContainmentClass)
	
	self.add_child(CostLabelScene.instantiate())
	CostLabel = self.get_child(4)
	CostLabel.update_label(CostAmount, ContainmentClass)

func activate(RootNode, CardPosition, Player):
	RootNode.basic_instakill_attack(CardPosition, DamageAmount, DamageType, Player, self)

func take_damage(Damage, _DamageType):
	HealthAmount -= Damage
	print("Card \"", CardName, "\" took ", Damage, " damage.")
	if HealthAmount <= 0:
		print("Card destroyed!")
		self.queue_free()
	HealthLabel.update_label(HealthAmount, ContainmentClass)
