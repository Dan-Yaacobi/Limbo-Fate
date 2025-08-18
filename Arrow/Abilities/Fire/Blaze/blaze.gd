class_name BlazeAbility extends ArrowAbility

const BUFF = preload("res://Player/Buffs/Buff.tscn")
const BLAZE_EFFECT = preload("res://Arrow/Abilities/Fire/Blaze/BlazeEffect.tscn")
const BURN_PARTICLE_2 = preload("res://Effects/Burn/BurnParticle2.tscn")
@export var buff_id = 1

func activate_ability(_enemy: Enemy, _arrow: Arrow) -> void:
	if _enemy.is_burnt() and GlobalPlayer.perfect_shot_counter % 2 == 0 and GlobalPlayer.perfect_shot_counter > 0:
		var speed_buff = BUFF.instantiate()
		speed_buff.buff_id = buff_id
		speed_buff.add_child(BLAZE_EFFECT.instantiate())
		
		var burn_particle = BURN_PARTICLE_2.instantiate()
		burn_particle.emitting = true
		speed_buff.add_child(burn_particle)
		GlobalPlayer.add_buff(speed_buff, PlayerStats.Stat.SPEED, 4, 0, 1)
