class_name HurtBox extends Area2D

@export var damage: int  = 1

func _ready() -> void:
	area_entered.connect(AreaEnetered)
	pass

func AreaEnetered( a : Area2D) -> void:
	if a is HitBox:
		a.TakeDamage(self)
		if get_parent() is Arrow:
			CombatTextSpawner.spawn(a.global_position, str(damage))
			get_parent().queue_free()
	pass
	
