extends Sprite2D

var cursor_path = preload("res://axe_cursor.png")
# Called when the node enters the scene tree for the first time.

func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func trigger_action():
	if SelectionManager.selected.size() > 0:
		SelectionManager.emit_signal("action", SelectionManager.action_types.cut, global_position)
