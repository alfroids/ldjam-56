@tool
class_name Creature
extends Area2D


@export var data: CreatureData:
	set(d):
		data = d
		if Engine.is_editor_hint() and d and d.texture:
			if not is_node_ready():
				await ready
			sprite_2d.texture = d.texture
@export var reward_spawn_position: Marker2D

var faith: int:
	set(f):
		f = clampi(f, 0, 3)
		if f != faith:
			faith = f
			SignalBus.faith_changed.emit()
			match f:
				3:
					faith_bar.value = 16
					faith_bar.tint_progress = Color("#63c74d")
				2:
					faith_bar.value = 10
					faith_bar.tint_progress = Color("#feae34")
				1:
					faith_bar.value = 6
					faith_bar.tint_progress = Color("#ff0044")
				0:
					faith_bar.value = 0
					faith_bar.tint_progress = Color("#5a6988")

@onready var sprite_2d: Sprite2D = $Sprite2D as Sprite2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer as AnimationPlayer
@onready var faith_bar: TextureProgressBar = $FaithBar as TextureProgressBar


func _ready() -> void:
	if not Engine.is_editor_hint():
		sprite_2d.texture = data.texture
		animation_player.play(&"idle")
		animation_player.speed_scale = 0.5
		faith = 1

		CycleManager.period_started.connect(_on_cycle_manager_period_started)
		SignalBus.player_grabbed_item.connect(_on_player_grabbed_item)
		SignalBus.player_released_item.connect(_on_player_released_item)


func _on_area_entered(_area: Area2D) -> void:
	var tween: Tween = create_tween()
	tween.tween_property(
		sprite_2d,
		^"scale",
		4 * Vector2.ONE,
		0.2
	).set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)


func _on_area_exited(_area: Area2D) -> void:
	var tween: Tween = create_tween()
	tween.tween_property(
		sprite_2d,
		^"scale",
		3 * Vector2.ONE,
		0.2
	).set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)


func _on_cycle_manager_period_started(period: CycleManager.PERIOD) -> void:
	if period & data.active_period:
		visible = true
		monitoring = true
		monitorable = true

	else:
		visible = false
		monitoring = false
		monitorable = false


func _on_player_grabbed_item(item_type: ItemManager.ITEM_TYPE) -> void:
	for trade in data.trades:
		if trade.request == item_type or trade.request == ItemManager.ITEM_TYPE.ANY:
			animation_player.play(&"excited")
			return


func _on_player_released_item(_item_type: ItemManager.ITEM_TYPE) -> void:
	animation_player.play(&"idle")


func collect(item: Item) -> void:
	for trade in data.trades:
		if trade.request == item.type or trade.request == ItemManager.ITEM_TYPE.ANY:
			spawn_reward(trade.reward)
			faith += 1
			SignalBus.traded_item.emit()
			return

	faith -= 1


func spawn_reward(reward_data: ItemData) -> void:
	var pos: Vector2 = reward_spawn_position.global_position if reward_spawn_position else global_position
	ItemManager.spawn_item(reward_data, pos)


#func _unhandled_input(event: InputEvent) -> void:
	#if event.is_action_pressed(&"ui_up"):
		#faith += 1
	#elif event.is_action_pressed(&"ui_down"):
		#faith -= 1
