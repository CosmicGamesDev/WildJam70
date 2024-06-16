extends Area2D

@export var parent : Node2D
@export var sprite : Sprite2D

# Called when the node enters the scene tree for the first time.
func _ready():
	mouse_entered.connect(_on_clickable_area_mouse_entered)
	mouse_exited.connect(_on_clickable_area_mouse_exited)
	sprite.material = sprite.material.duplicate()



func _on_clickable_area_mouse_entered():
	ClickableController.current_hover.push_back(parent)
	if parent == ClickableController.current_hover[0]:
		sprite.material.set_shader_parameter("thickness", 1)


func _on_clickable_area_mouse_exited():
	ClickableController.current_hover.erase(parent)
	sprite.material.set_shader_parameter("thickness", 0)


