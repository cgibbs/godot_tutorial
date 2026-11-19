extends Node2D


@onready var timer: Timer = $Timer
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D

# 0 = set
# 1 = pop and free
var phase = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	timer.start(0.2)
	print("starting timer")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	print(phase)
	if phase == 0:
		pass
	if phase == 1:
		queue_free()


func _on_timer_timeout() -> void:
	print("timer timeout")
	phase += 1
