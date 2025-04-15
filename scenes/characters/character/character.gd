extends CharacterBody2D
class_name Character

@onready var health_component: HealthComponent = get_node("%HealthComponent")
@onready var collision_shape_2d: CollisionShape2D = get_node("%CollisionShape2D")
@onready var animation_player: AnimationPlayer = get_node("%AnimationPlayer")
@onready var animated_sprite_2d: AnimatedSprite2D = get_node("%AnimatedSprite2D")
@onready var health_label: Label = get_node("%HealthLabel")
@onready var speed_label: Label = get_node("%SpeedLabel")
@onready var name_label: Label = get_node("%NameLabel")

@export var character_name: String:
	set(value):
		character_name = value
		if name_label:
			name_label.text = "name: " + str(character_name)
@export var attack_is_enabled: bool = true

@export_category("Movement")
@export var speed: float:
	set(value):
		speed = value
		if speed_label:
			speed_label.text = "speed: " + str(value)
@export var default_move_direction: Vector2 = Vector2.ZERO
@export var movement_is_enabled: bool = true:
	set(value):
		if not value:
			move_direction = Vector2.ZERO
			velocity = Vector2.ZERO
		movement_is_enabled = value

@export_category("Health")
@export var health: int
@export var max_health: int
@export var invulnerability_time: float = 0.4
@export var health_replenish_is_enabled: bool = true
@export var invulnerability_is_enabled: bool = false # note: don t use invulnerability_is_enabled, use health_component.invulnerability_is_enabled

@export_category("Labels")
@export var show_health_label: bool = false
@export var show_name_label: bool = false
@export var show_speed_label: bool = false

var move_direction: Vector2 = default_move_direction

func _ready():
	health_component.health = health
	health_component.max_health = max_health
	health_component.invulnerability_time = invulnerability_time
	health_component.health_replenish_is_enabled = health_replenish_is_enabled
	health_component.invulnerability_is_enabled = invulnerability_is_enabled
	health_label.visible = show_health_label
	name_label.visible = show_name_label
	speed_label.visible = show_speed_label
	speed_label.text = "speed: " + str(speed)
	name_label.text = "name: " + str(character_name)
	health_label.text = "health: " + str(health_component.health)

func _process(_delta):
	speed_label.text = "speed: " + str(speed)
	name_label.text = "name: " + str(character_name)
	health_label.text = "health: " + str(health_component.health)
	if movement_is_enabled:
		if move_direction.is_normalized():
			velocity = speed * move_direction
		else:
			velocity = speed * move_direction.normalized()
	move_and_slide()
