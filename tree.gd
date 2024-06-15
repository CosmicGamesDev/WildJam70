extends Sprite2D

var cursor_path = preload("res://axe_cursor.png")
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_clickable_area_mouse_entered():
	ClickableController.current_hover.push_back(self)
	if self == ClickableController.current_hover[0]:
		material.set_shader_parameter("thickness", 1)


func _on_clickable_area_mouse_exited():
	ClickableController.current_hover.erase(self)
	material.set_shader_parameter("thickness", 0)
