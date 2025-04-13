extends Character
class_name Player

@export var bullet: PackedScene

func _ready():
	assert(bullet)
	GlobalVars.player = self
	health_component.health = health
	health_component.max_health = max_health
	health_component.invulnerability_time = invulnerability_time
	health_component.health_replenish_is_enabled = health_replenish_is_enabled
	health_component.invulnerability_is_enabled = invulnerability_is_enabled
	health_label.visible = show_health_label
	name_label.visible = show_name_label
	speed_label.visible = show_speed_label

func _process(delta: float) -> void:
	move_direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	if Input.is_action_just_pressed("ui_accept"):
		shoot()
	super._process(delta)

func shoot():
	print("Spawned")
	var bullet_instance: Bullet = bullet.instantiate()
	bullet_instance.target_groups = ["enemy"]
	bullet_instance.target_global_position = get_global_mouse_position()
	add_child(bullet_instance)
