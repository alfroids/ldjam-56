extends Node


@warning_ignore("unused_signal")
signal player_grabbed_item(item_type: ItemManager.ITEM_TYPE)
@warning_ignore("unused_signal")
signal player_released_item(item_type: ItemManager.ITEM_TYPE)
@warning_ignore("unused_signal")
signal faith_changed()
@warning_ignore("unused_signal")
signal traded_item(creature: CreatureData, item: ItemData, reward: ItemData)
@warning_ignore("unused_signal")
signal new_trade_discovered()
@warning_ignore("unused_signal")
signal game_started()
@warning_ignore("unused_signal")
signal game_over()
@warning_ignore("unused_signal")
signal victory()
