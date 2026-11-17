extends Area2D

@onready var timer: Timer = $Timer

func _on_body_entered(_body: Node2D) -> void:
	timer.start()

func _on_timer_timeout() -> void:
	#get_tree().reload_current_scene()
	Input.action_press("reset_to_checkpoint")
	Input.action_release("reset_to_checkpoint")
