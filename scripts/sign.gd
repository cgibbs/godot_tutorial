extends Node2D

@onready var area_2d: Area2D = $Area2D
@onready var label: Label = $Label
@onready var label_2: Label = $Label2
@onready var label_3: Label = $Label3

@export var labelText: String
@export var labelText2: String
@export var labelText3: String

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	label.text = labelText
	label_2.text = labelText2
	label_3.text = labelText3
	pass # Replace with function body.

func _on_area_2d_body_entered(body: Node2D) -> void:
	print("entered")
	if body is CharacterBody2D:
		# make sign label visible
		label.visible = true
		label_2.visible = true
		label_3.visible = true
		pass

func _on_area_2d_body_shape_exited(body_rid: RID, _body: Node2D, body_shape_index: int, local_shape_index: int) -> void:
	# make sign label invisible
	label.visible = false
	label_2.visible = false
	label_3.visible = false
	pass
