extends Node


const CURSOR_DEFAULT: Texture2D = preload("res://assets/cursor_default.png")
const CURSOR_GRAB: Texture2D = preload("res://assets/cursor_grab.png")


func _ready() -> void:
	Input.set_custom_mouse_cursor(CURSOR_DEFAULT, Input.CURSOR_ARROW, Vector2(18, 18))

	SignalBus.player_grabbed_item.connect(_on_player_grabbed_item)
	SignalBus.player_released_item.connect(_on_player_released_item)


func _on_player_grabbed_item(_item_type: ItemManager.ITEM_TYPE) -> void:
	Input.set_custom_mouse_cursor(CURSOR_GRAB, Input.CURSOR_ARROW, Vector2(18, 18))


func _on_player_released_item(_item_type: ItemManager.ITEM_TYPE) -> void:
	Input.set_custom_mouse_cursor(CURSOR_DEFAULT, Input.CURSOR_ARROW, Vector2(18, 18))
