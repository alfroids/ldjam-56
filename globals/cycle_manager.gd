extends Node


signal period_started(period: PERIOD)

enum PERIOD {DAY=1, NIGHT=2}

@onready var current_cycle: int = 0
@onready var current_period: PERIOD = PERIOD.DAY:
	set(cp):
		current_period = cp
		if cp == PERIOD.DAY:
			current_cycle += 1
		period_started.emit(cp)


func reset_cycles() -> void:
	current_cycle = 0
	current_period = PERIOD.DAY


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed(&"ui_accept"):
		if current_period == PERIOD.DAY:
			current_period = PERIOD.NIGHT

		elif current_period == PERIOD.NIGHT:
			current_period = PERIOD.DAY
