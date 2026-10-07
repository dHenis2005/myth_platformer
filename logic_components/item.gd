extends Area2D

@export var item_name: String = "new"
@export var item_icon: Texture2D

var in_range = false
var player: CharacterBody2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)
	if item_icon:
		$Sprite2D.texture = item_icon

func _on_body_entered(body: CharacterBody2D):
	in_range = true
	player = body
	
func _on_body_exited(body: CharacterBody2D):
	in_range = false
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if in_range and Input.is_action_just_pressed("attack"):
		player.pick_item(item_icon)
		queue_free()
