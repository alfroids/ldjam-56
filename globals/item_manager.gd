extends Node2D


enum ITEM_TYPE {
	NONE,
	COIN,
	POTION,
	SWORD,
	HONEY,
	MUSHROOM,
}

@onready var item_scene: PackedScene = preload("res://scenes/item/item.tscn")


func spawn_item(item_data: ItemData, global_pos: Vector2) -> void:
	var item: Item = item_scene.instantiate() as Item
	item.data = item_data
	item.global_position = global_pos
	add_child(item)
