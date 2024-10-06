extends Node2D


@onready var animation_player: AnimationPlayer = $AnimationPlayer as AnimationPlayer


func _ready() -> void:
	SignalBus.traded_item.connect(_on_traded_item)


func _on_traded_item() -> void:
	animation_player.play(&"popup")
