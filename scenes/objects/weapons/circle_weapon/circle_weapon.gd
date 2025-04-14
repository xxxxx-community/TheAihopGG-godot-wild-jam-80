extends Weapon

func get_shoot_directions(target_vector: Vector2) -> Array[Vector2]:
	return [
		target_vector,
		Vector2(-target_vector.x, -target_vector.y),
		Vector2(-target_vector.y, target_vector.x),
		Vector2(target_vector.y, -target_vector.x)
	]

func _shoot(target_direction: Vector2, target_groups: Array[String]):
	if can_shoot:
		for direction in get_shoot_directions(target_direction):
			var bullet_instance = bullet.instantiate()

			bullet_instance.target_groups = target_groups
			bullet_instance.parent = parent
			bullet_instance.move_direction = direction
			
			add_child(bullet_instance)
		can_shoot = false
		duration_timer.start(duration)
