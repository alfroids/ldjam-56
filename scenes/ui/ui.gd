extends Control


@onready var faith_bar: TextureProgressBar = %FaithBar as TextureProgressBar
@onready var end_game_panel: Panel = $MarginContainer/EndGamePanel as Panel
@onready var label: Label = $MarginContainer/EndGamePanel/VBoxContainer/Label as Label
@onready var intro: Panel = $MarginContainer/Intro as Panel
@onready var tip: Label = $MarginContainer/Tip as Label
@onready var timer: Timer = $MarginContainer/Tip/Timer as Timer
@onready var game_started: bool = false

func _ready() -> void:
	end_game_panel.visible = false

	SignalBus.faith_changed.connect(_on_faith_changed)
	SignalBus.game_over.connect(_on_game_over)
	SignalBus.victory.connect(_on_victory)


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed(&"skip"):
		if not game_started:
			intro.visible = false
			game_started = true
			get_tree().paused = false

		tip.visible = false
		timer.start()


func _on_faith_changed() -> void:
	var total_faith: int = 0
	for creature: Creature in get_tree().get_nodes_in_group(&"creatures"):
		total_faith += creature.faith

	faith_bar.value = 2 + 9 * total_faith

	if faith_bar.value / faith_bar.max_value > 2.0 / 3.0:
		faith_bar.tint_progress = Color("#63c74d")
	elif faith_bar.value / faith_bar.max_value > 1.0 / 3.0:
		faith_bar.tint_progress = Color("#feae34")
	else:
		faith_bar.tint_progress = Color("#ff0044")

	if total_faith == 0:
		SignalBus.game_over.emit()
		return


func _on_game_over() -> void:
	get_tree().paused = true
	end_game_panel.modulate = Color("#ff0044")
	label.text = "game over..."
	end_game_panel.visible = true


func _on_victory() -> void:
	get_tree().paused = true
	end_game_panel.modulate = Color("#0095e9")
	label.text = "well done!"
	end_game_panel.visible = true


func _on_button_pressed() -> void:
	get_tree().quit()


func _on_timer_timeout() -> void:
	tip.visible = true
