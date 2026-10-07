extends CharacterBody2D

@onready var health: Health_Node = $Health_Node
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@export var speed: float = 0.0

var attack_timer: float = 3.0
var is_attacking: bool = false
var charge_direction: float = 0.0

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	if $flip/enemy_vision.target:
		
		if is_attacking:
			velocity.x = charge_direction * speed
		else:
			
			var direction = sign($flip/enemy_vision.target.global_position.x - global_position.x)
			if direction < 0:
				$flip.scale.x = -1.0
			elif direction > 0:
				$flip.scale.x = 1.0
			velocity.x = direction * speed
			attack_timer -= delta
			
			if attack_timer <= 0:
				is_attacking = true
				charge_direction = direction
				animation_player.play("attack")
			else:
				if animation_player.current_animation != "walk":
					animation_player.play("walk")
	else:
		velocity.x = move_toward(velocity.x, 0, 150)
		if !is_attacking and animation_player.current_animation != "RESET":
			animation_player.play("RESET")


	move_and_slide()

func _ready() -> void:
	health.died.connect(_on_enemy_die)
	animation_player.animation_finished.connect(_on_animation_finish)
	
func _on_enemy_die() -> void:
	print("died")
	queue_free()

func _on_animation_finish(anim: String) -> void:
	if anim == "attack":
		is_attacking = false
		attack_timer = 3.0
