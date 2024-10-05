extends Node


signal period_started(period: PERIOD)

enum PERIOD {DAY=1, NIGHT=2}

@onready var current_period: PERIOD = PERIOD.DAY


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed(&"ui_accept"):
		if current_period == PERIOD.DAY:
			current_period = PERIOD.NIGHT

		elif current_period == PERIOD.NIGHT:
			current_period = PERIOD.DAY

		period_started.emit(current_period)
