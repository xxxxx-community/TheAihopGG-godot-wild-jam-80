extends Enemy

@export var shoot_duration: float

@onready var shoot_timer: Timer = get_node("%ShootTimer")
@onready var square_enemy_weapon: Weapon = get_node("%SquareEnemyWeapon")
@onready var navigation_agent: NavigationAgent2D = get_node("%NavigationAgent2D")

var next_path_position: Vector2

func _ready():
	super._ready()
	navigation_agent.debug_enabled = GlobalVars.debug_is_enabled
	shoot_timer.start(shoot_duration)

func _process(delta):
	navigation_agent.target_position = target.global_position
	next_path_position = navigation_agent.get_next_path_position()
	move_direction = (next_path_position - global_position).normalized()
	super._process(delta)

func _on_shoot_timer_timeout() -> void:
	square_enemy_weapon._shoot(target.global_position - global_position, ["player"])
 

func _on_navigation_agent_2d_velocity_computed(safe_velocity: Vector2) -> void:
	velocity = safe_velocity
	move_and_slide()
