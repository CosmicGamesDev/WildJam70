extends Sprite2D

@onready var clickable_area_component = $ClickableAreaComponent

var current_mushroom
# Called when the node enters the scene tree for the first time.

func _ready():
	current_mushroom = randi_range(0,7)
	frame = current_mushroom

func trigger_action():
	if SelectionManager.selected.size() > 0:
		SelectionManager.handle_action(SelectionManager.action_types.pickup_mushroom, global_position, self)


func _on_pickup_area_area_entered(area):
	var parent = area.get_parent() as Node2D 
	if parent.is_in_group("gnome") and parent.state == SelectionManager.action_types.pickup_mushroom:
		parent.pickup(current_mushroom)
		ClickableController.current_hover.erase(clickable_area_component)
		queue_free()
