class_name StatVar extends Resource

@export var base: float = 0.0
var flat_sum: float = 0.0 
var mult_sum: float = 0.0     

func final_stat() -> float:
	return (base + flat_sum) * (1.0 + mult_sum)

func add_flat(x: float) -> void:
	flat_sum += x

func add_mult(x: float) -> void:
	mult_sum += x
