extends Area2D


# Called when the node enters the scene tree for the first time.
#func _ready() -> void:
	#pass # Replace with function body.
#
#
## Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
	#pass



func _on_body_entered(body: Node2D) -> void:
#	only detects objects on the same layer as the mask, e.g. Player is collision layer 2, so it'll 
#	be detected by a mask set to 2
	queue_free()
	
