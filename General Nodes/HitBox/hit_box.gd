class_name HitBox extends Area2D

signal Damaged( hurt_box: HurtBox )

var enemy: Enemy
func _ready() -> void:
	if get_parent() is Enemy:
		enemy = get_parent()
	pass 

func TakeDamage(hurt_box: HurtBox) -> void:
	Damaged.emit(hurt_box)
	pass

func get_enemy() -> Enemy:
	return enemy
