extends Area2D

@onready var game_manager: Node = %GameManager

@export var collected = false

func _ready() -> void:
	if (collected):
		visible = false
	else:
		visible = true


func _on_body_entered(_body: Node2D) -> void:
	if (collected): 
		return
#	only detects objects on the same layer as the mask, e.g. Player is collision layer 2, so it'll 
#	be detected by a mask set to 2
	collected = true
	game_manager.update_coin_count()
	visible = false
