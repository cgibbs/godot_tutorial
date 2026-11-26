extends Control

var menu_item_selected = 0
const num_menu_items = 2

@onready var label_0_pip: Sprite2D = $MarginContainer/VBoxContainer/Label2/label0_pip
@onready var label_1_pip: Sprite2D = $MarginContainer/VBoxContainer/Label3/label1_pip
@onready var start_screen: Control = $"."
@onready var player: CharacterBody2D = %Player


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	label_0_pip.visible = true
	label_0_pip.visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if start_screen.visible == false:
		return
	if Input.is_action_just_pressed("up"):
		menu_item_selected = (menu_item_selected + 1) % num_menu_items
	elif Input.is_action_just_pressed("down"):
		menu_item_selected = (menu_item_selected - 1) % num_menu_items
		# this is terrible but I don't actually care lmao
		if menu_item_selected < 0:
			menu_item_selected = num_menu_items - 1

	if menu_item_selected == 0:
		label_0_pip.visible = true
		label_1_pip.visible = false
	elif menu_item_selected == 1:
		label_0_pip.visible = false
		label_1_pip.visible = true
		
	if Input.is_action_just_pressed("jump"):
		if menu_item_selected == 0:
			start_screen.visible = false
			player.toggle_controls_for_ui()
		elif menu_item_selected == 1:
			print("I can't do that yet")
