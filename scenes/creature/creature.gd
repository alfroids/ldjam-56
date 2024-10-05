class_name Creature
extends Area2D


@export var data: CreatureData
@export var reward_spawn_position: Marker2D

@onready var sprite_2d: Sprite2D = $Sprite2D as Sprite2D


func _ready() -> void:
	if data and data.texture:
		sprite_2d.texture = data.texture

	CycleManager.period_started.connect(_on_cycle_manager_period_started)


func _on_area_entered(_area: Area2D) -> void:
	sprite_2d.scale = 4 * Vector2.ONE


func _on_area_exited(_area: Area2D) -> void:
	sprite_2d.scale = 3 * Vector2.ONE


func _on_cycle_manager_period_started(period: CycleManager.PERIOD) -> void:
	if period & data.active_period:
		visible = true
		monitoring = true
		monitorable = true

	else:
		visible = false
		monitoring = false
		monitorable = false


func collect(item: Item) -> bool:
	for trade in data.trades:
		if trade.request == item.type or trade.request == ItemManager.ITEM_TYPE.ANY:
			spawn_reward(trade.reward)
			return true

	return false


func spawn_reward(reward_data: ItemData) -> void:
	var pos: Vector2 = reward_spawn_position.global_position if reward_spawn_position else global_position
	ItemManager.spawn_item(reward_data, pos)
