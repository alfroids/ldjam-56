extends Node2D


const TOTAL_TRADES: int = 99

@onready var count: int = 0
@onready var label: Label = $Bubble/Label as Label


func _ready() -> void:
	SignalBus.new_trade_discovered.connect(_on_new_trade_discovered)
	label.text = str(count) + " / " + str(TOTAL_TRADES)


func _on_new_trade_discovered() -> void:
	count += 1
	label.text = str(count) + " / " + str(TOTAL_TRADES)

	if count == TOTAL_TRADES:
		SignalBus.victory.emit()
