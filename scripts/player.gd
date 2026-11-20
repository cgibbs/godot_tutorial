extends CharacterBody2D


const SPEED = 130.0
const JUMP_VELOCITY = -300.0

var knockback: Vector2 = Vector2.ZERO
var knockback_timer: float = 0.0

var has_dashed = false

var movement_disabled = false

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var timer: Timer = $CheckpointTimer
@onready var camera: Camera2D = $Camera2D


var has_enemy_bounce_powerup = false
var has_dash_powerup = false
var has_bomb_powerup = false
# this should probably just be for messing around in the post-game, it's way too strong
var has_balloon_powerup = false

var last_torch_x = 0
var last_torch_y = 0

var checkpoint_held_press_time = 0

var able_to_reset = true

var has_used_balloon = false

func _ready() -> void:
	last_torch_x = global_position.x
	last_torch_y = global_position.y

func reset_checkpoint() -> void:
	for torch in get_tree().get_nodes_in_group("Torches"):
		var animatedSprite = torch.get_node("AnimatedSprite2D");
		if animatedSprite:
			animatedSprite.play("unlit");
	last_torch_x = 0
	last_torch_y = 0
	position.x = 0
	position.y = 0
	checkpoint_held_press_time = 0
	Input.action_release("reset_to_checkpoint")
	timer.start()
	able_to_reset = false
	return

func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("bomb") and has_bomb_powerup:
		if (get_tree().get_node_count_in_group("Bombs") == 0):
			const BOMB = preload("../scenes/bomb.tscn")
			var bomb = BOMB.instantiate()
			get_tree().get_root().add_child(bomb)
			bomb.position = global_position
			bomb.position.y -= 8
			position.y -= 20
		#bomb.position.y += 20

		# create a bomb at the player's position

	
	if Input.is_action_pressed("reset_to_checkpoint") and able_to_reset:
		checkpoint_held_press_time += delta
		if checkpoint_held_press_time > 1:
			reset_checkpoint();
		
	if Input.is_action_just_released("reset_to_checkpoint") and able_to_reset:
		if checkpoint_held_press_time < 1:
			position.x = last_torch_x
			position.y = last_torch_y
			checkpoint_held_press_time = 0
			return
	
	if knockback_timer > 0.0:
		velocity = knockback
		knockback_timer -= delta
		if knockback_timer <= 0.0:
			knockback = Vector2.ZERO
	
	elif movement_disabled:
		pass
	
	else:
		# Add the gravity.
		if not is_on_floor():
			velocity += get_gravity() * delta

		if is_on_floor():
			has_used_balloon = false
			has_dashed = false

		# Handle jump.
		if Input.is_action_just_pressed("jump") and is_on_floor():
			velocity.y = JUMP_VELOCITY
		
		if Input.is_action_just_pressed("jump") and !is_on_floor() and has_balloon_powerup and !has_used_balloon:
			print("Laying down a balloon!")
			has_used_balloon = true
			const BALLOON = preload("../scenes/balloon.tscn")
			var balloon = BALLOON.instantiate()
			self.add_child(balloon)

		# Get the input direction and handle the movement/deceleration.
		# As good practice, you should replace UI actions with custom gameplay actions.
		var direction := Input.get_axis("move_left", "move_right")
		
		if is_on_floor():
			if direction == 0:
				animated_sprite.play("idle")
			else:
				animated_sprite.play("run")
		else:
			animated_sprite.play("jump")
		
		if Input.is_action_just_pressed("dash") and !is_on_floor() and has_dash_powerup and !has_dashed:
			apply_knockback(Vector2((1 if !animated_sprite.flip_h else -1) * SPEED, 0),3, .2, true)
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
		if velocity.y < JUMP_VELOCITY:
			velocity.y = JUMP_VELOCITY
		knockback = (velocity * (Vector2.UP + Vector2.RIGHT).normalized() * 1.2)
		knockback_timer = knockback_duration
	else:
		knockback = (direction * force)
		knockback_timer = knockback_duration


func _on_timer_timeout() -> void:
	able_to_reset = true
	pass # Replace with function body.
