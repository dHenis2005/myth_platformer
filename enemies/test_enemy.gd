extends CharacterBody2D

@onready var health: Health_Node = $Health_Node



func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	if $enemy_vision.target:
		var direction = sign($enemy_vision.target.global_position.x - global_position.x)
		velocity.x = direction*150
	else:
		velocity.x = move_toward(velocity.x, 0, 150)


	move_and_slide()

func _ready() -> void:
	health.died.connect(_on_enemy_die)
	
func _on_enemy_die() -> void:
	print("died")
	queue_free()
