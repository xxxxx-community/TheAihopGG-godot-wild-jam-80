extends Bullet

@export var enemy: PackedScene
@export var spawn_enemy_time: float

func _process(_delta):
	move_direction = (target_vector - global_position).normalized()
	velocity = speed * move_direction
	move_and_slide()

func _on_lifetime_expired() -> void:
	var enemy_instance: Enemy = enemy.instantiate()
	enemy_instance.target = GlobalVars.player
	enemy_instance.global_position = global_position
	GlobalVars.world.characters.add_child(enemy_instance)
	queue_free()
