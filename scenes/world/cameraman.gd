extends Node2D


@export var speed: float = 200.0


func _process(delta: float) -> void:
	var direction: Vector2 = Input.get_vector(&"move_left", &"move_right", &"move_up", &"move_down")
	position += delta * speed * direction
