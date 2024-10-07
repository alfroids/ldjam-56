class_name Storage
extends Area2D


@export var slots: Array[Marker2D]

@onready var items: Dictionary
@onready var animation_player: AnimationPlayer = $AnimationPlayer as AnimationPlayer


func _ready() -> void:
	for slot in slots:
		items[slot] = null

	SignalBus.player_grabbed_item.connect(_on_player_grabbed_item)
	SignalBus.player_released_item.connect(_on_player_released_item)


func store(item: Item) -> bool:
	for slot in slots:
		if not items[slot]:
			items[slot] = item
			var tween: Tween = create_tween()
			tween.tween_property(
				item,
				^"global_position",
				slot.global_position,
				item.global_position.distance_to(slot.global_position) / 800
			).set_ease(Tween.EASE_IN)
			item.removed_from_storage.connect(
				func():
					items[slot] = null
			)
			return true

	return false


func _on_player_grabbed_item(_item_type: ItemManager.ITEM_TYPE) -> void:
	animation_player.play(&"excited")


func _on_player_released_item(_item_type: ItemManager.ITEM_TYPE) -> void:
	animation_player.stop()
