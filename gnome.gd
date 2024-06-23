extends CharacterBody2D
class_name Gnome

var cursor_path = preload("res://pointer_cursor.png")
var mushroom_scene = preload("res://pickup_mushroom.tscn")
var log_scene = preload("res://log.tscn")
const SPEED = 30.0
var is_selected = false
@onready var nav_agent := $NavigationAgent2D as NavigationAgent2D
@onready var sprite_2d = $Sprite2D
@onready var pickup_area = $PickupArea
var tower
var has_item = false
var current_item = null
@onready var audio_stream_player_2d = $AudioStreamPlayer2D
@onready var animation_player = $AnimationPlayer
@onready var axe = $Axe


var state = SelectionManager.action_types.idle

signal selected(gnome)

func _ready():
	tower = get_tree().get_first_node_in_group("tower")
	SelectionManager.deselect.connect(_on_deselect)
	audio_stream_player_2d.play()
	axe.visible = false

func _physics_process(delta: float) -> void:
	if is_selected:
		outline(true)
		if Input.is_action_just_pressed("click") and ClickableController.current_hover.size() == 0:
			makepath(get_global_mouse_position())
	var next_path_pos := nav_agent.get_next_path_position()
	var direction := global_position.direction_to(next_path_pos)
	if global_position.distance_to(next_path_pos) < 2:
		velocity = Vector2.ZERO
		makepath(global_position)
	else:
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
	if SelectionManager.selected.size() != 0:
		SelectionManager.emit_signal("deselect")
	SelectionManager.selected = [self]
	is_selected = true
	outline(true)

func pickup(frame):
	if !has_item:
		SelectionManager.stop_others(current_item)
		has_item = true
		var mushroom = mushroom_scene.instantiate()
		add_child(mushroom)
		mushroom.global_position = pickup_area.global_position
		mushroom.frame = frame
		on_action(SelectionManager.action_types.returning, tower.global_position, mushroom)

func cutting():
	if !has_item:
		animation_player.play("cutting")

func return_to_tower():
	var log = log_scene.instantiate()
	has_item = true
	add_child(log)
	log.global_position = pickup_area.global_position
	on_action(SelectionManager.action_types.returning, tower.global_position, log)

func _on_deselect():
	is_selected = false
	outline(false)

func stop():
	current_item = null
	state = SelectionManager.action_types.idle
	makepath(global_position)

func on_action(type: SelectionManager.action_types, pos: Vector2, item):
	current_item = item
	state = type
	audio_stream_player_2d.play()
	makepath(pos)
