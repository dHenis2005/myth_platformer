extends CharacterBody2D

signal pick_up_item(icon: Texture2D)

@onready var health_node: Health_Node = $Health_Node
@onready var animation_player: AnimationPlayer = $AnimationPlayer
const SPEED = 300.0

var jump_velocity = 0.0
var jump_timer = 0.0
var is_jumping = false

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	#if Input. is_action_just_pressed("attack"):
		#animation_player.play("attack")

	if Input.is_action_just_pressed("move_down"):
		position.y += 1

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("move_left", "move_right")
	if direction:
		if direction < 0:
			$flip.scale.x = -1.0
			$platform_collision.position.x = 1
		elif direction > 0:
			$flip.scale.x = 1.0
			$platform_collision.position.x = -1
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		jump_velocity = -95
		is_jumping = true
	if (Input.is_action_pressed("jump") and jump_timer <= 0.5 and is_jumping):
		velocity.y += jump_velocity * delta * 60
		jump_timer += delta
		jump_velocity *= pow(0.85, delta * 60.0)
	if (Input.is_action_just_released("jump")):
		is_jumping = false
		if velocity.y < 0:
			velocity.y *= 0.5 
	if (!Input.is_action_pressed("jump") and is_on_floor()):
		jump_timer = 0.0
		jump_velocity = 0.0
	

	move_and_slide()
	
	if velocity.x != 0:
		if animation_player.current_animation != "walk":
			animation_player.play("walk")
	elif animation_player.current_animation != "RESER":
		animation_player.play("RESET")

func _ready() -> void:
	health_node.hp_change.connect(_on_player_hp_change)
	health_node.died.connect(_on_player_died)

func _on_player_hp_change(new_hp: float, max_hp: float) -> void:
	pass

func _on_player_died() -> void:
	queue_free()

func pick_item(icon: Texture2D) -> void:
	pick_up_item.emit(icon)
