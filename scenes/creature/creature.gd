class_name Creature
extends Area2D


@export var data: CreatureData
@export var reward_spawn_position: Marker2D

@onready var sprite_2d: Sprite2D = $Sprite2D as Sprite2D


func _ready() -> void:
	if data and data.texture:
		sprite_2d.texture = data.texture


func _on_area_entered(_area: Area2D) -> void:
	sprite_2d.scale = 4 * Vector2.ONE


func _on_area_exited(_area: Area2D) -> void:
	sprite_2d.scale = 3 * Vector2.ONE


func collect(item: Item) -> bool:
	if item.type == data.request:
		spawn_reward()
		return true

	return false


func spawn_reward() -> void:
	var pos: Vector2 = reward_spawn_position.global_position if reward_spawn_position else global_position
	ItemManager.spawn_item(data.reward, pos)
