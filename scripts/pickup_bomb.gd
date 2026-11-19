extends Area2D

@export var player: CharacterBody2D

func _on_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D:
		player.has_bomb_powerup = true
		queue_free()
