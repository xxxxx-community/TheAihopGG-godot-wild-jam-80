extends CharacterBody2D
class_name Character

@export var character_name: String
@export_category("Movement")
@export var speed: float
@export var default_move_direction: Vector2 = Vector2.ZERO
@export var movement_is_enabled: bool = true
@export var attack_is_enabled: bool = true
@export_category("Health")
@export var health: int
@export var max_health: int
@export var invulnerability_time: float
@export var health_replenish_is_enabled: bool = true
@export var invulnerability_is_enabled: bool = false # note: don t use invulnerability_is_enabled, use health_component.invulnerability_is_enabled
@export_category("Labels")
@export var show_health_label: bool = false
@export var show_name_label: bool = true
@export var show_speed_label: bool = true

@onready var health_component: HealthComponent = get_node("%HealthComponent")
@onready var animation_player: AnimationPlayer = get_node("%AnimationPlayer")
@onready var animated_sprite_2d: AnimatedSprite2D = get_node("%AnimatedSprite2D")
@onready var health_label: Label = get_node("%HealthLabel")
@onready var speed_label: Label = get_node("%SpeedLabel")
@onready var name_label: Label = get_node("%NameLabel")

var move_direction: Vector2 = default_move_direction

func _ready():
	health_component.health = health
	health_component.max_health = max_health
	health_component.invulnerability_time = invulnerability_time
	health_component.health_replenish_is_enabled = health_replenish_is_enabled
	health_component.invulnerability_is_enabled = invulnerability_is_enabled

func _process(_delta):
	if movement_is_enabled:
		velocity = speed * move_direction.normalized()
	show_labels()
	move_and_slide()

func show_labels():
	health_label.text = "health: " + str(health_component.health)
	health_label.visible = show_health_label
	speed_label.text = "speed: " + str(speed)
	speed_label.visible = show_speed_label
	name_label.text = "name: " + str(character_name)
	name_label.visible = show_name_label
