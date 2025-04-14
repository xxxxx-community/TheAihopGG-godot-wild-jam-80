extends Weapon

func get_shoot_vectors(target_vector: Vector2) -> Array[Vector2]:
	return [
		target_vector,
		Vector2(-target_vector.x, -target_vector.y),
		Vector2(-target_vector.y, target_vector.x),
		Vector2(target_vector.y, -target_vector.x)
	]
