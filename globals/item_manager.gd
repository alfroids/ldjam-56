extends Node2D


enum ITEM_TYPE {
	NONE,
	ANY,
	AXE,
	BEE,
	BOMB,
	COIN,
	DOUBLE_AXE,
	EMPTY_BUCKET,
	EYE,
	FAITH,
	FIRE,
	GOLD_DUST,
	HAMMER,
	HEALTH_POTION,
	HONEY,
	ICE,
	KEY,
	MAGIC_CRYSTAL,
	MANA_POTION,
	MUSHROOM,
	OBSIDIAN_DUST,
	PICKAXE,
	ROCK,
	SHIELD,
	SICKLE,
	SLIME,
	SPEAR,
	SWORD,
	WATER,
	WATER_BUCKET,
	WIZARD_STAFF,
	WOOD,
}

@onready var item_scene: PackedScene = preload("res://scenes/item/item.tscn")


func spawn_item(item_data: ItemData, global_pos: Vector2) -> void:
	var item: Item = item_scene.instantiate() as Item
	item.data = item_data
	item.global_position = global_pos
	add_child(item)
