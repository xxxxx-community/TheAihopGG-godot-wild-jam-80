extends Weapon

@export var count: int
@export var shoot_angle: int

func get_shoot_vectors(target_vector: Vector2) -> Array[Vector2]:
	var vectors: Array[Vector2]
	var target_vector_angle: float = rad_to_deg(target_vector.normalized().angle())
	for i in range(count):
		var deg = randi_range(target_vector_angle - (shoot_angle / 2), target_vector_angle + (shoot_angle / 2))
		vectors.append(Vector2.from_angle(deg_to_rad(deg)) * target_vector.length())
	return vectors
