extends Enemy

@export var shoot_time: float
@export var min_distance_to_target: float

@onready var shoot_timer: Timer = get_node("%ShootTimer")
@onready var circle_weapon: Weapon = get_node("%CircleWeapon")

func _ready():
	super._ready()
	shoot_timer.wait_time = shoot_time
	shoot_timer.start()

func _process(delta):
	if global_position.distance_to(target.global_position) > min_distance_to_target:
		move_direction = (target.global_position - global_position).normalized()
	else:
		move_direction = -(target.global_position - global_position).normalized()
	super._process(delta)

func _on_shoot_timer_timeout() -> void:
	circle_weapon._shoot((target.global_position - global_position).normalized(), ["player"])
