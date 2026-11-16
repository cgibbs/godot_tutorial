extends CharacterBody2D


const SPEED = 130.0
const JUMP_VELOCITY = -300.0

var knockback: Vector2 = Vector2.ZERO
var knockback_timer: float = 0.0

var has_dashed = false

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D

var has_enemy_bounce_powerup = true
var has_dash_powerup = true

func _physics_process(delta: float) -> void:
	if knockback_timer > 0.0:
		velocity = knockback
		knockback_timer -= delta
		if knockback_timer <= 0.0:
			knockback = Vector2.ZERO
			
	else:
		# Add the gravity.
		if not is_on_floor():
			velocity += get_gravity() * delta

		if is_on_floor():
			has_dashed = false

		# Handle jump.
		if Input.is_action_just_pressed("jump") and is_on_floor():
			velocity.y = JUMP_VELOCITY
			

		# Get the input direction and handle the movement/deceleration.
		# As good practice, you should replace UI actions with custom gameplay actions.
		var direction := Input.get_axis("move_left", "move_right")
		
		if Input.is_action_just_pressed("dash") and has_dash_powerup and !has_dashed:
			apply_knockback(Vector2(direction * SPEED, 0),3, .2, true)
			has_dashed = true
		
		if direction:
			if direction > 0:
				animated_sprite.flip_h = false
			elif direction < 0:
				animated_sprite.flip_h = true
			velocity.x = direction * SPEED
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()

func apply_knockback(direction: Vector2, force: float, knockback_duration: float, ignore_powerup: bool = false) -> void:
	if (has_enemy_bounce_powerup and !ignore_powerup):
		#if is_on_floor():
			#position.y -= 2
		if velocity.y < JUMP_VELOCITY:
			velocity.y = JUMP_VELOCITY
		knockback = velocity * (Vector2.UP + Vector2.RIGHT).normalized() * 1.2
		knockback_timer = knockback_duration
	else:
		knockback = direction * force
		knockback_timer = knockback_duration
