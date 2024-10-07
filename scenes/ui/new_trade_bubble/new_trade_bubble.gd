extends Node2D


@onready var animation_player: AnimationPlayer = $AnimationPlayer as AnimationPlayer
@onready var creature: Sprite2D = $Creature as Sprite2D
@onready var item: Sprite2D = $Bubble/Item as Sprite2D
@onready var reward: Sprite2D = $Bubble/Reward as Sprite2D
@onready var history: Dictionary = {}


func _ready() -> void:
	SignalBus.traded_item.connect(_on_traded_item)


func _on_traded_item(creature_data: CreatureData, item_data: ItemData, reward_data: ItemData) -> void:
	var is_new: bool = true
	if creature_data not in history:
		history[creature_data] = {}
	if item_data not in history[creature_data]:
		history[creature_data][item_data] = []
	if reward_data not in history[creature_data][item_data]:
		history[creature_data][item_data].append(reward_data)
	else:
		is_new = false

	if is_new:
		animation_player.stop()
		creature.texture = creature_data.texture
		item.texture = item_data.texture
		reward.texture = reward_data.texture
		animation_player.play(&"popup")
		SignalBus.new_trade_discovered.emit()
