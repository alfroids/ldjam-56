class_name Item
extends Area2D


signal removed_from_storage()

var data: ItemData
var type: ItemManager.ITEM_TYPE:
	get:
		return data.type if data else ItemManager.ITEM_TYPE.NONE

@onready var is_in_focus: bool = false
@onready var is_grabbed: bool = false:
	set(ig):
		if not is_grabbed and ig:
			SignalBus.player_grabbed_item.emit(type)
			sprite_2d.material.set_shader_parameter(&"outline_color", Color("fee761"))
			audio_stream_player.play()
		elif is_grabbed and not ig:
			SignalBus.player_released_item.emit(type)
			sprite_2d.material.set_shader_parameter(&"outline_color", Color("ffffff"))
			audio_stream_player.play()
		is_grabbed = ig
@onready var is_in_storage: bool = false:
	set(iis):
		if is_in_storage and not iis:
			removed_from_storage.emit()
		is_in_storage = iis
@onready var offset: Vector2 = Vector2.ZERO
@onready var sprite_2d: Sprite2D = $Sprite2D as Sprite2D
@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer as AudioStreamPlayer


func _ready() -> void:
	sprite_2d.material.set_shader_parameter(&"outline_width", 0)

	if data and data.texture:
		sprite_2d.texture = data.texture

	CycleManager.period_started.connect(_on_cycle_manager_period_started)


func _process(_delta: float) -> void:
	if is_in_focus:
		if Input.is_action_just_pressed(&"grab"):
			is_grabbed = true
			is_in_storage = false
			offset = get_global_mouse_position() - global_position

		elif Input.is_action_just_released(&"grab"):
			is_grabbed = false
			offset = Vector2.ZERO

			var overlapping_areas: Array[Area2D] = get_overlapping_areas()
			for area in overlapping_areas:
				if area is Creature:
					(area as Creature).collect(self)
					queue_free()
					break

				elif area is Storage:
					var was_stored: bool = (area as Storage).store(self)
					if was_stored:
						is_in_storage = true

	if is_grabbed:
		global_position = get_global_mouse_position() - offset


func _on_mouse_entered() -> void:
	is_in_focus = true
	sprite_2d.material.set_shader_parameter(&"outline_width", 1)


func _on_mouse_exited() -> void:
	is_in_focus = false
	sprite_2d.material.set_shader_parameter(&"outline_width", 0)


func _on_cycle_manager_period_started(_period: CycleManager.PERIOD) -> void:
	if not is_in_storage:
		queue_free()
