extends Weapon
class_name BossWeapon

@export var count: int

func get_shoot_vectors(target_vector: Vector2) -> Array[Vector2]:
	var vectors: Array[Vector2]
	var angle = rad_to_deg(int(360 / float(count)))
	var current_angle: float = rad_to_deg(target_vector.normalized().angle())
	for i in range(count):
		vectors.append(Vector2.from_angle(deg_to_rad(current_angle)) * target_vector.length())
		current_angle += angle
	return vectors
