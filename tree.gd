extends Sprite2D

var cursor_path = preload("res://axe_cursor.png")
# Called when the node enters the scene tree for the first time.


func trigger_action():
	if SelectionManager.selected.size() > 0:
		SelectionManager.handle_action(SelectionManager.action_types.cut, global_position)
