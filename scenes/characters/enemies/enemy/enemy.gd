extends Character
class_name Enemy

@export var default_target: Character
@export var collide_damage: int = 10
@export var collide_damage_duration: float = 1

@onready var collide_damage_timer = get_node("%CollideDamageTimer")
@onready var attack_area: Area2D = get_node("%AttackArea")

var target: Character

func _ready():
	super._ready()
	if not default_target:
		default_target = GlobalVars.player

func _process(delta):
	move_direction = (default_target.global_position - global_position).normalized()
	super._process(delta)

func is_target(body: Node2D) -> bool:
	for group in default_target.get_groups():
		if not body.is_in_group(group):
			return false
	return true

func _on_attack_area_body_entered(body: Node2D) -> void:
	if is_target(body):
		target = body
		target.health_component._take_damage(collide_damage)
		collide_damage_timer.start(collide_damage_duration)

func _on_collide_damage_timer_timeout() -> void:
	if target:
		target.health_component._take_damage(collide_damage)
		collide_damage_timer.start(collide_damage_duration)

func _on_attack_area_body_exited(body: Node2D) -> void:
	if is_target(body):
		target = null
