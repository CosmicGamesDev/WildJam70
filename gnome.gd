extends CharacterBody2D

var cursor_path = preload("res://pointer_cursor.png")
const SPEED = 30.0
var is_selected = false
@onready var nav_agent := $NavigationAgent2D as NavigationAgent2D
@onready var sprite_2d = $Sprite2D

signal selected(gnome)

func _ready():
	SelectionManager.action.connect(_on_action)
	SelectionManager.deselect.connect(_on_deselect)

func _physics_process(_delta: float) -> void:
	if is_selected:
		outline(true)
		if Input.is_action_just_pressed("click") and ClickableController.current_hover.size() == 0:
			makepath(get_global_mouse_position())
	var next_path_pos := nav_agent.get_next_path_position()
	var direction := global_position.direction_to(next_path_pos)
	velocity = direction * SPEED
	move_and_slide()

func makepath(target):
	nav_agent.target_position = target

func outline(on):
	if on:
		sprite_2d.material.set_shader_parameter("thickness", 1)
	else:
		sprite_2d.material.set_shader_parameter("thickness", 0)

func trigger_action():
	SelectionManager.selected = [self]
	is_selected = true
	outline(true)

func _on_deselect():
	is_selected = false
	outline(false)

func _on_action(type: int, pos: Vector2):
	makepath(pos)
