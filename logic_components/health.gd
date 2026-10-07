extends Node
class_name Health_Node

@export var max_hp: float = 100.0
@onready var curr_hp: float = max_hp

signal hp_change(new_hp: float, max_hp: float)
signal died

func take_damage(damage: float) -> void:
	curr_hp -= damage
	curr_hp = max(0.0, curr_hp)
	hp_change.emit(curr_hp, max_hp)
	if curr_hp <= 0.0:
		died.emit()
