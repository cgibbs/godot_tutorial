extends CharacterBody2D


const SPEED = 130.0
const JUMP_VELOCITY = -300.0

var knockback: Vector2 = Vector2.ZERO
var knockback_timer: float = 0.0

var has_enemy_bounce_powerup = true

func _physics_process(delta: float) -> void:
	if knockback_timer > 0.0:
		print("in knockback timer!")
		velocity = knockback
		knockback_timer -= delta
		if knockback_timer <= 0.0:
			knockback = Vector2.ZERO
			
	else:
		# Add the gravity.
		if not is_on_floor():
			velocity += get_gravity() * delta

		# Handle jump.
		if Input.is_action_just_pressed("ui_accept") and is_on_floor():
			velocity.y = JUMP_VELOCITY

		# Get the input direction and handle the movement/deceleration.
		# As good practice, you should replace UI actions with custom gameplay actions.
		var direction := Input.get_axis("ui_left", "ui_right")
		if direction:
			velocity.x = direction * SPEED
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()

func apply_knockback(direction: Vector2, force: float, knockback_duration: float) -> void:
	if (has_enemy_bounce_powerup):
		print("has enemy bounce powerup")
		knockback = velocity * (Vector2.UP + Vector2.RIGHT).normalized()
		knockback_timer = knockback_duration
	else:
		print("knockback applied!")
		knockback = direction * force
		knockback_timer = knockback_duration
