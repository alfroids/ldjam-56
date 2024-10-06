class_name Storage
extends Area2D


@export var slots: Array[Marker2D]

@onready var items: Dictionary


func _ready() -> void:
	for slot in slots:
		items[slot] = null


func store(item: Item) -> bool:
	for slot in slots:
		if not items[slot]:
			items[slot] = item
			item.global_position = slot.global_position
			item.removed_from_storage.connect(
				func():
					items[slot] = null
			)
			return true

	return false
