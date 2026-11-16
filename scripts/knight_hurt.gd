extends Node2D

@export var timer: Timer

# when collide with something that hurts the knight,
# disable player movement for duration of timer and 
# push knight away from center of object at a 
# pre-determined angle and velocity

const BOUNCEBACK_SPEED = 50

var has_bounced = false

@export var player: CharacterBody2D

@export var nodePath: Path2D

func _on_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D:
		var knockback_direction = (body.global_position - global_position).normalized()
		player.apply_knockback(knockback_direction,100, 0.12)
		print("knight hurt!")
