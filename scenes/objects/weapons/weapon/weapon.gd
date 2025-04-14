extends Node
class_name Weapon

@export var bullet: PackedScene
@export var duration: float
@export var parent: Character = self.get_parent().get_parent() if self.get_parent() else null

@onready var duration_timer: Timer = get_node("%DurationTimer")

var can_shoot: bool = true

func _ready():
	assert(bullet)

func get_shoot_directions(target_vector: Vector2) -> Array[Vector2]:
	return [target_vector]

func _shoot(target_direction: Vector2, target_groups: Array[String]):
	if can_shoot and parent.attack_is_enabled:
		for direction in get_shoot_directions(target_direction):
			var bullet_instance = bullet.instantiate()
			bullet_instance._setup(direction, target_groups, parent)
			add_child(bullet_instance)
		can_shoot = false
		duration_timer.start(duration)

func _on_duration_timer_timeout() -> void:
	can_shoot = true
