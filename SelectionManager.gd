extends Node2D

var selected = []

signal action(act_type, pos)
signal deselect

enum action_types {
	gather,
	cut
}

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("deselect"):
		selected = []
		emit_signal("deselect")
