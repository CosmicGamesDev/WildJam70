extends Area2D

@export var parent : Node2D
@export var sprite : Sprite2D
@export var cursor_path = preload("res://axe_cursor.png")
# Called when the node enters the scene tree for the first time.
func _ready():
	mouse_entered.connect(_on_clickable_area_mouse_entered)
	mouse_exited.connect(_on_clickable_area_mouse_exited)
	sprite.material = sprite.material.duplicate()



func _on_clickable_area_mouse_entered():
	ClickableController.current_hover.push_back(self)
	if self == ClickableController.current_hover[0]:
		ClickableController.change_cursor(cursor_path)
		sprite.material.set_shader_parameter("thickness", 1)


func _on_clickable_area_mouse_exited():
	ClickableController.current_hover.erase(self)
	sprite.material.set_shader_parameter("thickness", 0)
	if ClickableController.current_hover.size() > 0:
		ClickableController.change_cursor(ClickableController.current_hover[0].cursor_path)
	else:
		ClickableController.change_cursor()


