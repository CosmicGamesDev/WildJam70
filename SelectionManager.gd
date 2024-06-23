extends Node2D

var selected = []

signal deselect

enum action_types {
	pickup_mushroom,
	cut,
	idle,
	move,
	returning
}

var dragging = false
var drag_start = Vector2.ZERO  # Location where drag began.
var select_rect = RectangleShape2D.new() 



func _unhandled_input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed:
			# If the mouse was clicked and nothing is selected, start dragging
			if selected.size() == 0:
				dragging = true
				drag_start = event.position
		# If the mouse is released and is dragging, stop dragging
		elif dragging:
			dragging = false
			queue_redraw()
			var drag_end = event.position
			select_rect.extents = abs(drag_end - drag_start) / 2
			var space = get_world_2d().direct_space_state
			var query = PhysicsShapeQueryParameters2D.new()
			query.shape = select_rect
			query.collision_mask = 2  # Units are on collision layer 2
			query.transform = Transform2D(0, (drag_end + drag_start) / 2)
			var queried_selected = space.intersect_shape(query)
			for unit in queried_selected:
				selected.push_back(unit.collider)
				unit.collider.is_selected = true
	if event is InputEventMouseMotion and dragging:
		queue_redraw()

func _draw():
	if dragging:
		draw_rect(Rect2(drag_start, get_global_mouse_position() - drag_start),
				Color.YELLOW, false, 2.0)
		z_index = 0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("click") and ClickableController.current_hover.size() > 0:
		ClickableController.current_hover[0].parent.trigger_action()
	if Input.is_action_just_pressed("deselect"):
		selected = []
		emit_signal("deselect")

func handle_action(action: action_types, pos: Vector2, item):
	for unit in selected:
		unit.on_action(action, pos, item)
		
func stop_others(current_item):
	var gnomes = get_tree().get_nodes_in_group("gnome")
	for gnome in gnomes:
		if gnome.current_item == current_item:
			gnome.stop()
	
