extends Node2D

@export var tree_scene = preload("res://tree.tscn")
@export var intial_tree_amount = 5

# Called when the node enters the scene tree for the first time.
func _ready():
	var root = get_tree().root
	var view = get_viewport_rect()
	for spawn in intial_tree_amount:
		var tree = tree_scene.instantiate()
		root.add_child.call_deferred(tree)
		tree.global_position = Vector2(randi_range(0,view.size.x), randi_range(0,view.size.y))
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_spawn_timer_timeout():
	pass # Replace with function body.
