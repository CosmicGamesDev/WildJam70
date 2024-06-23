extends Sprite2D

var cursor_path = preload("res://axe_cursor.png")
# Called when the node enters the scene tree for the first time.


func trigger_action():
	if SelectionManager.selected.size() > 0:
		SelectionManager.handle_action(SelectionManager.action_types.cut, global_position, self)


func _on_cut_area_area_entered(area):
	var parent = area.get_parent() as Node2D 
	if parent.is_in_group("gnome") and parent.state == SelectionManager.action_types.cut:
		parent.cutting()
