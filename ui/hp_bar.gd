extends TextureProgressBar

@export var player_hp: Health_Node
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if player_hp:
		max_value = player_hp.max_hp
		value = player_hp.curr_hp
		player_hp.hp_change.connect(_on_player_hp_change)
		
func _on_player_hp_change(new_hp: float, max_hp: float) -> void:
	max_value = max_hp
	value = new_hp

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
