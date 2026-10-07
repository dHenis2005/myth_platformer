extends Area2D
class_name Damage_hitbox

@export var health_node: Health_Node

func take_hit(damage: float) -> void:
	if health_node:
		health_node.take_damage(damage)
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
