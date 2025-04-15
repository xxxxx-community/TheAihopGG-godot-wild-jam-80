extends Component
class_name EnemySpawnerComponent

@export var start_wave_spawn_duration: float
@export var enemy_spawn_delay_time: float
@export var enemy_container_node: Node
@export var min_distance_to_player: float
@export var max_distance_to_player: float
@export var spawn_waves_is_enabled: bool = true

@onready var wave_spawn_duration_timer: Timer = get_node("%WaveSpawnDurationTimer")
@onready var enemy_spawn_delay_timer = get_node("%EnemySpawnDelayTimer")

const JUNIOR_ENEMIES: Array[PackedScene] = [
	preload("res://scenes/characters/enemies/triangle_enemy/triangle_enemy.tscn"),
]
const MIDDLE_ENEMIES: Array[PackedScene] = [
	preload("res://scenes/characters/enemies/square_enemy/square_enemy.tscn"),
]
const SENIOR_ENEMIES: Array[PackedScene] = [
	preload("res://scenes/characters/enemies/circle_enemy/circle_enemy.tscn"),
]
const FINAL_BOSS: PackedScene = preload("res://scenes/characters/bosses/hexagon_boss/hexagon_boss.tscn")

signal enemy_spawned(enemy: Enemy)
signal wave_spawned()

var current_wave: Array[Enemy]

func _ready():
	assert(max_distance_to_player > min_distance_to_player)
	assert(enemy_container_node)
	wave_spawn_duration_timer.start(start_wave_spawn_duration + GlobalVars.chaos_value)
	spawn_wave(generate_wave(round(GlobalVars.chaos_value * 0.5), round(GlobalVars.chaos_value * 0.10), round(GlobalVars.chaos_value * 0.05)))

func spawn_wave(wave: Array[Enemy]) -> void:
	if spawn_waves_is_enabled:
		current_wave = wave
		current_wave.shuffle()
		enemy_spawn_delay_timer.start(enemy_spawn_delay_time)
		wave_spawn_duration_timer.start(start_wave_spawn_duration + GlobalVars.chaos_value)

func generate_wave(junior_enemies_count: int, middle_enemies_count: int, senior_enemies_count: int) -> Array[Enemy]:
	var wave: Array[Enemy]
	wave.append_array(generate_enemies_from_array(junior_enemies_count, JUNIOR_ENEMIES))
	wave.append_array(generate_enemies_from_array(middle_enemies_count, MIDDLE_ENEMIES))
	wave.append_array(generate_enemies_from_array(senior_enemies_count, SENIOR_ENEMIES))
	return wave

func generate_enemies_from_array(enemies_count: int, enemies_array: Array[PackedScene]) -> Array[Enemy]:
	var arr: Array[Enemy]
	while enemies_count > 0:
		var enemy: Enemy = enemies_array[randi_range(0, len(enemies_array) - 1)].instantiate()
		enemy.target = GlobalVars.player
		enemy.global_position = Vector2.from_angle(deg_to_rad(randi_range(0, 360))) * randi_range(min_distance_to_player, max_distance_to_player) + GlobalVars.player.global_position
		arr.append(enemy)
		enemies_count -= 1
	return arr

func _on_wave_spawn_duration_timer_timeout() -> void:
	if GlobalVars.chaos_value < 20:
		spawn_wave(generate_wave(round(GlobalVars.chaos_value * 0.5), round(GlobalVars.chaos_value * 0.10), round(GlobalVars.chaos_value * 0.05)))
	else:
		if spawn_waves_is_enabled:
			# spawn final boss
			var boss = FINAL_BOSS.instantiate()
			boss.target = GlobalVars.player
			enemy_container_node.add_child(boss)
			spawn_waves_is_enabled = false

func _on_enemy_spawn_delay_timer_timeout() -> void:
	if current_wave:
		var enemy = current_wave[0]
		current_wave.remove_at(0)
		enemy_container_node.add_child(enemy)
		enemy_spawned.emit(enemy)
		enemy_spawn_delay_timer.start(enemy_spawn_delay_time)
	else:
		wave_spawned.emit()
