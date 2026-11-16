extends StaticBody2D

@export var area_2d: Area2D
@export var player: CharacterBody2D

func _on_area_2d_body_entered(body: Node2D) -> void:
	print("entered")
	if body is CharacterBody2D:
		var knockback_direction = (Vector2(0, player.velocity.y).normalized() * player.SPEED + (body.global_position - global_position)).normalized()
		player.apply_knockback(knockback_direction,100, 0.22, true)
		player.movement_disabled = true
		


func _on_area_2d_body_exited(body: Node2D) -> void:
	player.movement_disabled = false
