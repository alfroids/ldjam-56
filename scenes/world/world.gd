extends Node2D


@onready var canvas_modulate: CanvasModulate = $CanvasModulate as CanvasModulate


func _ready() -> void:
	CycleManager.period_started.connect(_on_cycle_manager_period_started)
	CycleManager.reset_cycles()


func _on_cycle_manager_period_started(period: CycleManager.PERIOD) -> void:
	var target_color: Color = Color("#124e89") if period == CycleManager.PERIOD.NIGHT else Color.WHITE
	var tween: Tween = create_tween()
	tween.tween_property(
		canvas_modulate,
		^"color",
		target_color,
		0.5
	).set_ease(Tween.EASE_IN_OUT)
