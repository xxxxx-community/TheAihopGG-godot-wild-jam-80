extends CharacterBody2D
class_name Character

@export var character_name: String
@export var speed: float
@export var default_move_direction: Vector2 = Vector2.RIGHT
@export var movement_is_enabled: bool = true
@export var attack_is_enabled: bool = true

@onready var animation_player: AnimationPlayer = get_node("%AnimationPlayer")
@onready var animated_sprite_2d: AnimatedSprite2D = get_node("%AnimatedSprite2D")

var move_direction: Vector2 = default_move_direction
