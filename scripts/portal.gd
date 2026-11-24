extends Area2D

@export var exitPortal: Area2D
@export var closeOnExit: bool = false
@export var coinsRequired: int = 0

@onready var use_cooldown_timer: Timer = $UseCooldownTimer
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var animation_timer: Timer = $AnimationTimer
@onready var game_manager: Node = %GameManager

var has_been_recently_used = false
var closed = false
var inactive = false

func _ready() -> void:
	# will probably need to ask the game manager, instead
	check_coin_count_reached(game_manager.collected_coins)
	if inactive:
		animated_sprite.play("inactive")

func _on_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D and !closed and !has_been_recently_used and !inactive:
		exitPortal.use_cooldown_timer.start(1)
		exitPortal.has_been_recently_used = true
		body.global_position = exitPortal.global_position
		body.camera.global_position = exitPortal.global_position
		animation_timer.start(0.5)



func _on_body_exited(_body: Node2D) -> void:
	has_been_recently_used = false
	if closeOnExit:
		closed = true
		animated_sprite.play("close")


func _on_use_cooldown_timer_timeout() -> void:
	has_been_recently_used = false


func open() -> void:
	closed = false
	animated_sprite.play("open")
	has_been_recently_used = true


# change from open to idle
func _on_animated_sprite_2d_animation_finished() -> void:
	print(animated_sprite.animation)
	if (animated_sprite.animation == "open"):
		animated_sprite.play("idle")

# just a quick access function for use via game manager
func check_coin_count_reached(coinCount) -> void:
	if (coinCount >= coinsRequired):
		inactive = false
		animated_sprite.play("idle")
	else:
		inactive = true
		animated_sprite.play("inactive")
