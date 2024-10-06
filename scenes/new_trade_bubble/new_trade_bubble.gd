extends Node2D


@onready var animation_player: AnimationPlayer = $AnimationPlayer as AnimationPlayer
@onready var creature: Sprite2D = $Creature as Sprite2D
@onready var item: Sprite2D = $Bubble/Item as Sprite2D
@onready var reward: Sprite2D = $Bubble/Reward as Sprite2D


func _ready() -> void:
	SignalBus.traded_item.connect(_on_traded_item)


func _on_traded_item(creature_data: CreatureData, item_data: ItemData, reward_data: ItemData) -> void:
	animation_player.stop()
	creature.texture = creature_data.texture
	item.texture = item_data.texture
	reward.texture = reward_data.texture
	animation_player.play(&"popup")
