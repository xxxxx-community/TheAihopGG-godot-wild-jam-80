extends Boss

@export var shoot_time: float:
	set(value):
		shoot_time = value
		if shoot_timer:
			shoot_timer.wait_time = value
@export var spawn_enemy_time: float
@export var update_total_point_time: float
@export var shotgun_distance: float

@onready var shoot_timer: Timer = get_node("%ShootTimer")
@onready var update_total_point_timer: Timer = get_node("%UpdateTotalPointTimer")
@onready var spawn_enemy_timer: Timer = get_node("%SpawnEnemyTimer")
@onready var shotgun_weapon: Weapon = get_node("%ShotgunWeapon")
@onready var boss_weapon: BossWeapon = get_node("%BossWeapon")
@onready var player_weapon: Weapon = get_node("%PlayerWeapon")
@onready var navigation_agent: NavigationAgent2D = get_node("%NavigationAgent2D")

var total_point: Vector2
var total_phase: int = 1
var next_path_position

func _ready():
	super._ready()
	navigation_agent.debug_enabled = GlobalVars.debug_is_enabled
	shoot_timer.start(shoot_time)
	spawn_enemy_timer.start(spawn_enemy_time)
	update_total_point_timer.start(update_total_point_time)

func _process(delta):
	navigation_agent.target_position = total_point
	next_path_position = navigation_agent.get_next_path_position()
	move_direction = (total_point - global_position).normalized()
	if global_position.distance_to(total_point) <= 10:
		total_point = get_random_vector_near_player()
		
	super._process(delta)

func _on_shoot_timer_timeout() -> void:
	if total_phase == 1:
		shotgun_weapon._shoot(target.global_position - global_position, ["player"])
	elif total_phase == 2:
		if global_position.distance_to(target.global_position) <= shotgun_distance:
			shotgun_weapon._shoot(target.global_position - global_position, ["player"])
		else:
			boss_weapon._shoot(target.global_position - global_position, ["player"])
	elif total_phase == 3:
		boss_weapon._shoot(target.global_position - global_position, ["player"])
	elif total_phase == 4:
		if randi_range(1, 2) == 1:
			shotgun_weapon._shoot(target.global_position - global_position, ["player"])
		else:
			boss_weapon._shoot(target.global_position - global_position, ["player"])
	elif total_phase == 5:
		boss_weapon._shoot(target.global_position - global_position, ["player"])

func get_random_vector_near_player() -> Vector2:
	return Vector2(
		randi_range(target.position.x / 3, target.position.x * 3),
		randi_range(target.position.y / 3, target.position.y * 3)
	)
func _on_update_total_point_timer_timeout() -> void:
	total_point = get_random_vector_near_player()

func _on_spawan_enemy_timer_timeout() -> void:
	if total_phase == 2:
		player_weapon._shoot(get_random_vector_near_player(), [])

func _on_health_component_health_reduced(_old_health: int, new_health: int) -> void:
	if new_health <= 900:
		total_phase = 2
		boss_weapon.count = 40
	if new_health <= 700:
		total_phase = 3
		speed = 200
		boss_weapon.count = 30
		shoot_time = 0.8
	if new_health <= 500:
		total_phase = 4
		speed = 400
		shotgun_weapon.count = 3
		shoot_time = 6
		shotgun_weapon.bullet = preload("res://scenes/objects/bullets/spawn_square_enemy_bullet/spawn_enemy_bullet.tscn")
	if new_health <= 200:
		total_phase = 5
		boss_weapon.count = 60
