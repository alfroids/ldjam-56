extends Marker2D

enum PERIOD {
	DAY=CycleManager.PERIOD.DAY,
	NIGHT=CycleManager.PERIOD.NIGHT,
	DAY_AND_NIGHT=CycleManager.PERIOD.DAY + CycleManager.PERIOD.NIGHT,
}

@export var item_data: ItemData
@export var active_period: PERIOD = PERIOD.DAY


func _ready() -> void:
	CycleManager.period_started.connect(_on_cycle_manager_period_started)


func _on_cycle_manager_period_started(period: CycleManager.PERIOD) -> void:
	if period & active_period:
		ItemManager.spawn_item(item_data, global_position)
