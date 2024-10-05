extends Node2D


@onready var canvas_modulate: CanvasModulate = $CanvasModulate as CanvasModulate


func _ready() -> void:
	CycleManager.period_started.connect(_on_cycle_manager_period_started)
	CycleManager.reset_cycles()


func _on_cycle_manager_period_started(period: CycleManager.PERIOD) -> void:
	if period == CycleManager.PERIOD.DAY:
		canvas_modulate.color = Color.WHITE

	elif period == CycleManager.PERIOD.NIGHT:
		canvas_modulate.color = Color("#262b44")
