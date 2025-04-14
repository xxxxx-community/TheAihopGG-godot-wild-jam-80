extends Enemy

@export var shoot_duration: float

@onready var shoot_timer: Timer = get_node("%ShootTimer")
@onready var square_enemy_weapon: Weapon = get_node("%SquareEnemyWeapon")

func _ready():
	super._ready()
	shoot_timer.start(shoot_duration)
	
func _process(delta):
	move_direction = (default_target.global_position - global_position).normalized()
	super._process(delta)

func _on_shoot_timer_timeout() -> void:
	square_enemy_weapon._shoot((default_target.global_position - global_position).normalized(), ["player"])
