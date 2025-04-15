extends Enemy

@export var shoot_time: float
@export var min_distance_to_target: float

@onready var shoot_timer: Timer = get_node("%ShootTimer")
@onready var circle_weapon: Weapon = get_node("%CircleWeapon")
@onready var navigation_agent: NavigationAgent2D = get_node("%NavigationAgent2D")

var next_path_position: Vector2

func _ready():
	super._ready()
	shoot_timer.wait_time = shoot_time
	navigation_agent.debug_enabled = GlobalVars.debug_is_enabled
	shoot_timer.start()

func _process(delta):
	navigation_agent.target_position = (target.global_position - global_position).normalized() * -min_distance_to_target + target.global_position
	next_path_position = navigation_agent.get_next_path_position()
	move_direction = (next_path_position - global_position).normalized()

	super._process(delta)

func _on_shoot_timer_timeout() -> void:
	circle_weapon._shoot(target.global_position - global_position, ["player"])
