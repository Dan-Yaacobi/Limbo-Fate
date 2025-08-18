class_name Buff extends Node2D

@onready var buff_timer: Timer = $BuffTimer

@export var flat: float
@export var multiplier: float
@export var duration: float
var stat

var target_stats: PlayerStats

var track_buff: Dictionary = {
	"stat": null,
	"flat": 0,
	"mult" : 0,
}
var stat_to_change: StatVar

func _ready() -> void:
	target_stats = GlobalPlayer.stats
	if buff_timer:
		buff_timer.timeout.connect(end_buff)

func apply_buff(stat: StringName, _duration: float, _flat: float, _mult: float) -> void:
	if stat:
		stat_to_change = target_stats.get_stat(stat)
		stat_to_change.add_flat(_flat)
		stat_to_change.add_mult(_mult)
		
		track_buff["stat"] = stat
		track_buff["flat"] = _flat
		track_buff["mult"] = _mult
		buff_timer.wait_time = _duration
		buff_timer.start()

func reapply_buff() -> void:
	buff_timer.start()
	pass

func end_buff() -> void:
	if target_stats:
		stat_to_change.add_flat(track_buff["flat"] * -1)
		stat_to_change.add_mult(track_buff["mult"] * -1)
	queue_free()
