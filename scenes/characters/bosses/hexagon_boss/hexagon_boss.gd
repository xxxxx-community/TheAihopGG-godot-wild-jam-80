extends Boss

@export var shoot_time: float
@export var spawn_enemy_time: float
@export var update_total_point_time: float
@export var shotgun_distance: float

@onready var shoot_timer: Timer = get_node("%ShootTimer")
@onready var update_total_point_timer: Timer = get_node("%UpdateTotalPointTimer")
@onready var spawn_enemy_timer: Timer = get_node("%SpawnEnemyTimer")
@onready var shotgun_weapon: Weapon = get_node("%ShotgunWeapon")
@onready var boss_weapon: Weapon = get_node("%BossWeapon")
@onready var player_weapon: Weapon = get_node("%PlayerWeapon")

var total_point: Vector2

func _ready():
	super._ready()
	shoot_timer.start(shoot_time)
	spawn_enemy_timer.start(spawn_enemy_time)
	update_total_point_timer.start(update_total_point_time)

func _process(delta):
	move_direction = (total_point - global_position).normalized()
	if global_position.distance_to(total_point) <= 10:
		total_point = get_random_vector_near_player()
	super._process(delta)

func _on_shoot_timer_timeout() -> void:
	if global_position.distance_to(target.global_position) <= shotgun_distance:
		shotgun_weapon._shoot(target.global_position - global_position, ["player"])
	else:
		boss_weapon._shoot(target.global_position - global_position, ["player"])

func get_random_vector_near_player() -> Vector2:
	return Vector2(
		randi_range(target.position.x / 2, target.position.x * 2),
		randi_range(target.position.y / 2, target.position.y * 2)
	)
func _on_update_total_point_timer_timeout() -> void:
	total_point = get_random_vector_near_player()

func _on_spawn_enemy_timer_timeout() -> void:
	player_weapon._shoot(get_random_vector_near_player(), [])
