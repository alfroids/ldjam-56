class_name DragObject
extends Area2D


@onready var is_in_focus: bool = false
@onready var is_grabbed: bool = false
@onready var offset: Vector2 = Vector2.ZERO
@onready var drop_area: DropArea
@onready var sprite_2d: Sprite2D = $Sprite2D as Sprite2D


func _process(_delta: float) -> void:
	if is_in_focus:
		if Input.is_action_just_pressed(&"grab"):
			is_grabbed = true
			offset = get_global_mouse_position() - global_position
		elif Input.is_action_just_released(&"grab"):
			is_grabbed = false
			offset = Vector2.ZERO

			for area in get_overlapping_areas():
				if area is DropArea:
					drop_area = area

			if drop_area:
				global_position = drop_area.global_position

	if is_grabbed:
		global_position = get_global_mouse_position() - offset


func _on_mouse_entered() -> void:
	is_in_focus = true
	sprite_2d.scale *= 1.1


func _on_mouse_exited() -> void:
	is_in_focus = false
	sprite_2d.scale /= 1.1
