extends Control


@onready var faith_bar: TextureProgressBar = %FaithBar as TextureProgressBar


func _ready() -> void:
	SignalBus.faith_changed.connect(_on_faith_changed)


func _on_faith_changed() -> void:
	var total_faith: int = 0
	for creature: Creature in get_tree().get_nodes_in_group(&"creatures"):
		total_faith += creature.faith
	faith_bar.value = 2 + 9 * total_faith
