class_name CreatureData
extends Resource


enum PERIOD {
	DAY=CycleManager.PERIOD.DAY,
	NIGHT=CycleManager.PERIOD.NIGHT,
	DAY_AND_NIGHT=CycleManager.PERIOD.DAY + CycleManager.PERIOD.NIGHT,
}

@export var texture: Texture2D
@export var active_period: PERIOD = PERIOD.DAY
@export var trades: Array[TradeData]
