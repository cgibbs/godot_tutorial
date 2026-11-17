extends Node2D

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@export var player: CharacterBody2D
@onready var collision_shape: CollisionShape2D = $Area2D/CollisionShape2D

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D:
		player.last_torch_x = collision_shape.global_position.x
		player.last_torch_y = collision_shape.global_position.y
		for torch in get_tree().get_nodes_in_group("Torches"):
			var animatedSprite = torch.get_node("AnimatedSprite2D");
			if animatedSprite:
				animatedSprite.play("unlit");
		animated_sprite.play("lit")
