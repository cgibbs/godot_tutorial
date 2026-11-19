extends AnimatableBody2D
@onready var green_sprite: Sprite2D = $GreenSprite
@onready var yellow_sprite: Sprite2D = $YellowSprite
@onready var ice_sprite: Sprite2D = $IceSprite

# Editor will enumerate as 0, 1 and 2.
@export_enum("Green", "Yellow", "Ice") var platform_type = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if platform_type == 0:
		green_sprite.visible = true
	elif platform_type == 1:
		yellow_sprite.visible = true
	elif platform_type == 2:
		ice_sprite.visible = true
	
