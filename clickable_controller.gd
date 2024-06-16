extends Node2D

var cursor_path = preload("res://default_cursor.png")
var is_default_cursor = true
var current_hover = []


func _process(delta):
	if current_hover.size() > 0:
		is_default_cursor = false
		Input.set_custom_mouse_cursor(current_hover[0].cursor_path)
	elif current_hover.size() == 0 and !is_default_cursor:
		is_default_cursor = true
		Input.set_custom_mouse_cursor(cursor_path)
	
	if Input.is_action_just_pressed("click") and current_hover.size() > 0:
		current_hover[0].trigger_action()
		
		
