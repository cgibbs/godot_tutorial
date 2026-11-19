extends CharacterBody2D

# 0 = set
# 1 = faster animation
# 2 = explode
# 3 = destroy self
var phase = 0
var timerVal = 1
var hasProcessedExplosionForWalls = false

@onready var timer: Timer = $Timer
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var player: CharacterBody2D = get_tree().get_first_node_in_group("Player")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	timer.start(1)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if phase == 1:
		animated_sprite.speed_scale = 2
		# setting the timer for the explosion phase
		timerVal = 0.5
	if phase == 2:
		animated_sprite.play("explode")
		if (!hasProcessedExplosionForWalls):
			hasProcessedExplosionForWalls = true
			for wall in get_tree().get_nodes_in_group("Bombable"):
				if (wall.global_position.distance_to(global_position) < 30):
					wall.queue_free()
			if (player.global_position.distance_to(global_position) < 60):
				var knockback_direction = (player.global_position - global_position).normalized()
				player.apply_knockback(knockback_direction,200, 0.12, true)
		# do the block destruction
	if phase == 3:
		queue_free()


func _on_timer_timeout() -> void:
	phase += 1
	timer.start(timerVal)

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta
		
		move_and_slide()
