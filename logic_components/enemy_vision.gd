extends Area2D
class_name Enemy_vision

var target: CharacterBody2D = null
var timer: float = 0
var see: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)

func _on_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D:
		target = body
		$Alert.set_deferred("disabled", false)
		timer = 5
		see = true

func _on_body_exited(body: Node2D) -> void:
	if body == target:
		see = false
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if !see:
		timer -= 1*delta
	if timer <= 0:
		$Alert.disabled = true
		timer = 0
		target = null
