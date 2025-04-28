extends Node2D

var HealthLabelScene = preload("res://Root/Labels/health_label.tscn")
var DamageLabelScene = preload("res://Root/Labels/damage_label.tscn")
var CostLabelScene = preload("res://Root/Labels/cost_label.tscn")
var HealthLabel
var DamageLabel
var CostLabel

var MaxHealth = 5
var HealthAmount = 5
var DamageAmount = 2
var CostAmount = 1
var DamageType = 0

@onready var Description = "Yo"

func _ready():
	self.add_child(DamageLabelScene.instantiate())
	DamageLabel = self.get_child(1)
	DamageLabel.update_label(DamageAmount)
	
	self.add_child(HealthLabelScene.instantiate())
	HealthLabel = self.get_child(2)
	HealthLabel.update_label(HealthAmount)
	
	self.add_child(CostLabelScene.instantiate())
	CostLabel = self.get_child(3)
	CostLabel.update_label(CostAmount)

func activate(RootNode, CardPosition, Player):
	RootNode.basic_common_attack(CardPosition, DamageAmount, DamageType, Player)
	if Player == 1:				#TODO: shitcode
		self.position.y -= 50
		var tween = get_tree().create_tween()
		tween.tween_property(self, "position", Vector2(), 0.25)
	else:
		self.position.y += 50
		var tween = get_tree().create_tween()
		tween.tween_property(self, "position", Vector2(), 0.25)

func take_damage(Damage, _DamageType):
	HealthAmount -= Damage
	print("Card took ", Damage, " damage.")
	if HealthAmount <= 0:
		print("Card destroyed!")
		self.queue_free()
	HealthLabel.update_label(HealthAmount)
