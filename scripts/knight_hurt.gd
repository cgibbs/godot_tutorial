extends Node2D

@export var timer: Timer

const BOUNCEBACK_SPEED = 50

var has_bounced = false

@export var player: CharacterBody2D

@export var nodePath: Path2D

func _on_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D:
		if has_bounced == false:
			var knockback_direction = (body.global_position - global_position).normalized()
			player.apply_knockback(knockback_direction,100, 0.12)
			print("knight hurt!")
	print(scene_file_path)
	if scene_file_path.split('/')[-1] == "enemy_purple.tscn":
		timer.start()
		has_bounced = true
		

func _on_timer_timeout() -> void:
	has_bounced = false
