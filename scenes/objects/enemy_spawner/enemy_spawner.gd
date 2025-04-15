extends Node
class_name EnemySpawner

@export var wave_spawn_duration: float
@export var enemy_container_node: Node
@export var min_distance_to_player: float
@export var max_distance_to_player: float
@export var spawn_waves_is_enabled: bool = true

@onready var wave_spawn_duration_timer: Timer = get_node("%WaveSpawnDurationTimer")

const JUNIOR_ENEMIES: Array[PackedScene] = [
	preload("res://scenes/characters/enemies/triangle_enemy/triangle_enemy.tscn"),
]
const MIDDLE_ENEMIES: Array[PackedScene] = [
	preload("res://scenes/characters/enemies/square_enemy/square_enemy.tscn"),
]
const SENIOR_ENEMIES: Array[PackedScene] = [
	preload("res://scenes/characters/enemies/circle_enemy/circle_enemy.tscn"),
]

signal enemy_spawned(enemy: Enemy)
signal wave_spawned(wave: Array[Enemy])

func _ready():
	assert(max_distance_to_player > min_distance_to_player)
	wave_spawn_duration_timer.start(wave_spawn_duration)
	spawn_wave()

func spawn_wave() -> void:
	if spawn_waves_is_enabled:
		var wave: Array[Enemy] = generate_wave(5, 3, 2)
		for enemy in wave:
			enemy_container_node.add_child(enemy)
			enemy_spawned.emit(enemy)
		wave_spawned.emit(wave)

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
	spawn_wave()
