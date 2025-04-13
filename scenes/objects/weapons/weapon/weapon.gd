extends Node
class_name Weapon

@export var bullet: PackedScene
@export var duration: float = 1
@export var parent: Character

@onready var duration_timer: Timer = get_node("%DurationTimer")

var can_shoot: bool = true

func _ready():
	assert(bullet)

func _shoot(target_vector: Vector2, target_groups: Array):
	print(can_shoot)
	if can_shoot:
		var bullet_instance: Bullet = bullet.instantiate()
		bullet_instance.target_groups = ["enemy"]
		bullet_instance.target_global_position = target_vector
		bullet_instance.parent = parent
		add_child(bullet_instance)
		can_shoot = false
		duration_timer.start(duration)

func _on_duration_timer_timeout() -> void:
	can_shoot = true
