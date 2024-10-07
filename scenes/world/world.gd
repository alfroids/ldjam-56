extends Node2D


@onready var canvas_modulate: CanvasModulate = $CanvasModulate as CanvasModulate


func _ready() -> void:
	CycleManager.period_started.connect(_on_cycle_manager_period_started)
	SignalBus.game_started.connect(_on_game_started)
	get_tree().paused = true


func _on_cycle_manager_period_started(period: CycleManager.PERIOD) -> void:
	var target_color: Color = Color("#124e89") if period == CycleManager.PERIOD.NIGHT else Color.WHITE
	var tween: Tween = create_tween()
	tween.tween_property(
		canvas_modulate,
		^"color",
		target_color,
		0.5
	).set_ease(Tween.EASE_IN_OUT)


func _on_game_started() -> void:
	CycleManager.reset_cycles()
