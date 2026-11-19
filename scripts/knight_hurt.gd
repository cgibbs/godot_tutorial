extends Node2D

@export var timer: Timer

const BOUNCEBACK_SPEED = 50

var has_bounced = false

@onready var player: CharacterBody2D = $"../../Player"
@onready var animation_player: AnimationPlayer = $AnimatedSprite2D/AnimationPlayer

@export var nodePath: Path2D
@export var floating: bool = false

func _ready() -> void:
	if (floating):
		animation_player.play("float")

func _on_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D:
		if has_bounced == false:
			var knockback_direction = (body.global_position - global_position).normalized()
			player.apply_knockback(knockback_direction,100, 0.12)
	print(scene_file_path)
	if scene_file_path.split('/')[-1] == "enemy_purple.tscn":
		timer.start()
		has_bounced = true
		

func _on_timer_timeout() -> void:
	has_bounced = false
