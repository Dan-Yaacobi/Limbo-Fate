class_name BlazeAbility extends ArrowAbility

const BUFF = preload("res://Player/Buffs/Buff.tscn")
const BLAZE_EFFECT = preload("res://Arrow/Abilities/Fire/Blaze/BlazeEffect.tscn")
const BURN_PARTICLE_2 = preload("res://Effects/Burn/BurnParticle2.tscn")

func activate_ability(_enemy: Enemy, _arrow: Arrow) -> void:
	if _enemy.is_burnt() and GlobalPlayer.perfect_shot_counter > 0:
		var speed_buff = BUFF.instantiate()
		speed_buff.add_child(BLAZE_EFFECT.instantiate())
		var burn_particle = BURN_PARTICLE_2.instantiate()
		speed_buff.add_child(burn_particle)
		burn_particle.emitting = true
		GlobalPlayer.add_child(speed_buff)
		speed_buff.apply_buff(PlayerStats.Stat.SPEED, 4, 0, 0.5)
