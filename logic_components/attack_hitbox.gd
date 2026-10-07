extends Area2D
class_name Attack_hitbox

@export var damage: float = 10.0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	area_entered.connect(_on_area_entered)

func _on_area_entered(area: Area2D) -> void:
	if area is Damage_hitbox:
		area.take_hit(damage)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
