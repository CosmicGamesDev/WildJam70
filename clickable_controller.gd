extends Node2D

var cursor_path = preload("res://default_cursor.png")
var is_default_cursor = true
var current_hover = []

func change_cursor(path = cursor_path):
	Input.set_custom_mouse_cursor(path)

