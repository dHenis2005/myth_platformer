extends Control

@export var player: CharacterBody2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if player:
		player.pick_up_item.connect(_add_item)

func _add_item(icon: Texture2D) -> void:
	print("The icon is: ", icon) # <--- ADD THIS
	var new_icon = TextureRect.new()
	new_icon.texture = icon
	new_icon.custom_minimum_size = Vector2(48, 48) 
	
	new_icon.expand_mode = TextureRect.EXPAND_FIT_WIDTH_PROPORTIONAL
	new_icon.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED
	$FoldableContainer/HBoxContainer.add_child(new_icon)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
