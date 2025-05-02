extends Node2D

var SCPNumberScene = preload("res://Root/Labels/number_label.tscn")
var HealthLabelScene = preload("res://Root/Labels/health_label.tscn")
var DamageLabelScene = preload("res://Root/Labels/damage_label.tscn")
var CostLabelScene = preload("res://Root/Labels/cost_label.tscn")
var SCPNumberLabel
var HealthLabel
var DamageLabel
var CostLabel

var MaxHealth = 8
var HealthAmount = MaxHealth
var DamageAmount = 7
var CostAmount = 3
var DamageType = "Basic"

var TurnPlayedOn
var HighestAmountOfCards

@onready var SCPNumber = "173"
@onready var CardName = "The Sculpture"
@onready var Description = "SCP-173 can only move while unobserved:\nThis card takes longer to attack the more cards are on the table."
@onready var ContainmentClass = "Euclid"

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
	if TurnPlayedOn == null:
		TurnPlayedOn = get_tree().root.get_child(0).get_child(0).Turn
	var Turn = get_tree().root.get_child(0).get_child(0).Turn
	var AmountOfCards = get_tree().root.get_child(0).get_child(0).get_amount_of_active_cards()
	var AmountOfTurnsExisted = Turn - TurnPlayedOn
	Description = str("SCP-173 can only move while unobserved:\nThis card takes longer to attack the more cards are on the table.\nIt will attack in ", AmountOfCards - AmountOfTurnsExisted, " turns.")
	if Turn - TurnPlayedOn >= AmountOfCards:
		RootNode.basic_common_attack(CardPosition, DamageAmount, DamageType, Player, self)
		TurnPlayedOn = null
	else:
		var Position = Vector2.ZERO
		Position.x -= 10
		var tween1 = get_tree().create_tween()
		tween1.tween_property(self, "position", Position, 0.1)
		await get_tree().create_timer(0.1).timeout
		Position.x += 20
		var tween2 = get_tree().create_tween()
		tween2.tween_property(self, "position", Position, 0.1)
		await get_tree().create_timer(0.1).timeout
		Position.x -= 20
		var tween3 = get_tree().create_tween()
		tween3.tween_property(self, "position", Position, 0.1)
		await get_tree().create_timer(0.1).timeout
		Position.x += 10
		var tween4 = get_tree().create_tween()
		tween4.tween_property(self, "position", Position, 0.1)

func take_damage(Damage, _DamageType):
	HealthAmount -= Damage
	print("Card \"", CardName, "\" took ", Damage, " damage.")
	if HealthAmount <= 0:
		print("Card destroyed!")
		self.queue_free()
	HealthLabel.update_label(HealthAmount, ContainmentClass)
