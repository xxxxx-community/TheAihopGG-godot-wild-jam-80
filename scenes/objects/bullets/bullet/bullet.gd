extends CharacterBody2D
class_name Bullet

@export var speed: float = 1000
@export var damage: int = 10
@export var lifetime: float = 10
@export var delete_after_hit: bool = true

@onready var attack_area: Area2D = get_node("%AttackArea")
@onready var animation_player: AnimationPlayer = get_node("%AnimationPlayer")
@onready var lifetime_timer: Timer = get_node("%LifetimeTimer")

var move_direction: Vector2
var target_groups: Array[String]
var target_global_position: Vector2
var parent: Character

signal lifetime_expired()
signal hit(character: Character)

func _ready():
	global_position = parent.global_position
	move_direction = (target_global_position - global_position).normalized()
	look_at(target_global_position)
	lifetime_timer.start(lifetime)

func _process(_delta):
	velocity = speed * move_direction
	move_and_slide()

func is_target(body: Node2D) -> bool:
	for group in target_groups:
		if not body.is_in_group(group):
			return false
	return true

func _on_attack_area_body_entered(body: Node2D) -> void:
	if is_target(body):
		var target: Character = body
		target.health_component._take_damage(damage)
		if GlobalVars.AnimationsNames.hit in animation_player.get_animation_list():
			target.play(GlobalVars.AnimationsNames.hit)
		else:
			hit.emit(target)
			if delete_after_hit:
				queue_free()

func _on_lifetime_timer_timeout() -> void:
	lifetime_expired.emit()
	queue_free()
