extends Node2D

@export var player: CharacterBody2D

func _on_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D:
		player.has_dash_powerup = true
		queue_free()
