class_name DropArea
extends Area2D


@onready var sprite_2d: Sprite2D = $Sprite2D as Sprite2D


func _on_area_entered(_area: Area2D) -> void:
	sprite_2d.scale *= 1.1


func _on_area_exited(_area: Area2D) -> void:
	sprite_2d.scale /= 1.1
