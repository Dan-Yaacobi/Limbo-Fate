class_name HurtBox extends Area2D

@export var damage: int  = 1

func _ready() -> void:
	area_entered.connect(AreaEnetered)
	pass

func AreaEnetered( a : Area2D) -> void:
	if a is HitBox:
		a.TakeDamage(self)
		CombatTextSpawner.spawn(a.global_position, str(damage))
		var arrow = get_parent()
		if arrow is Arrow:
			arrow.apply_ability(a.get_enemy())
			arrow.queue_free()
	pass
	
