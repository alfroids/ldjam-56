class_name Item
extends Area2D


var data: ItemData
var type: ItemManager.ITEM_TYPE:
	get:
		return data.type if data else ItemManager.ITEM_TYPE.COIN

@onready var is_in_focus: bool = false
@onready var is_grabbed: bool = false
@onready var offset: Vector2 = Vector2.ZERO
@onready var sprite_2d: Sprite2D = $Sprite2D as Sprite2D


func _ready() -> void:
	sprite_2d.material.set_shader_parameter(&"outline_width", 0)

	if data and data.texture:
		sprite_2d.texture = data.texture


func _process(_delta: float) -> void:
	if is_in_focus:
		if Input.is_action_just_pressed(&"grab"):
			is_grabbed = true
			offset = get_global_mouse_position() - global_position

		elif Input.is_action_just_released(&"grab"):
			is_grabbed = false
			offset = Vector2.ZERO

			var overlapping_areas: Array[Area2D] = get_overlapping_areas()
			for area in overlapping_areas:
				if area is Creature:
					var was_collected: bool = (area as Creature).collect(self)

					if was_collected:
						queue_free()

					break

	if is_grabbed:
		global_position = get_global_mouse_position() - offset


func _on_mouse_entered() -> void:
	is_in_focus = true
	sprite_2d.material.set_shader_parameter(&"outline_width", 1)


func _on_mouse_exited() -> void:
	is_in_focus = false
	sprite_2d.material.set_shader_parameter(&"outline_width", 0)
