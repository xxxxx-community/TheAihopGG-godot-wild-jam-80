extends Character
class_name Player

@export var weapons: Array[Weapon]
@export var default_weapon_index: int

var total_weapon_index: int = default_weapon_index:
	set(value):
		if weapons:
			if value < len(weapons):
				total_weapon_index = value
			else:
				total_weapon_index = len(weapons) - 1

func _ready():
	GlobalVars.player = self
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

func _process(delta: float) -> void:
	print(total_weapon_index)
	move_direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	if Input.is_action_just_pressed("shoot"):
		if weapons:
			weapons[total_weapon_index]._shoot(get_global_mouse_position(), ["enemy"])
	if Input.is_action_just_pressed("select_weapon_1"):
		total_weapon_index = 0
	if Input.is_action_just_pressed("select_weapon_2"):
		total_weapon_index = 1
	if Input.is_action_just_pressed("select_weapon_3"):
		total_weapon_index = 2
	super._process(delta)
