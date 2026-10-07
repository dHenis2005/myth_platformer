extends Area2D

@export var item: PackedScene
@export var icon: Texture2D

var in_range = false
var opened = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)

func _on_body_entered(body: CharacterBody2D) -> void:
	in_range = true
	
func _on_body_exited(body: CharacterBody2D) -> void:
	in_range = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if in_range and Input.is_action_just_pressed("attack") and !opened:
		$AnimatedSprite2D.play()
		opened = true
		spawn_item()

func spawn_item() -> void:
	if item:
		var item_object = item.instantiate()
		item_object.global_position = global_position
		item_object.item_icon = icon
		get_tree().current_scene.add_child(item_object)
