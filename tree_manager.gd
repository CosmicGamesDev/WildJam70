extends Node2D

@export var tree_scene = preload("res://tree.tscn")
@export var intial_tree_amount = 5
@onready var navigation_region_2d = $"../NavigationRegion2D"

# Called when the node enters the scene tree for the first time.
func _ready():
	var view = get_viewport_rect()
	for spawn in intial_tree_amount:
		var tree = tree_scene.instantiate()
		navigation_region_2d.add_child.call_deferred(tree)
		tree.global_position = Vector2(randi_range(0,view.size.x), randi_range(0,view.size.y))
	await get_tree().create_timer(1).timeout
	navigation_region_2d.bake_navigation_polygon()
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_spawn_timer_timeout():
	pass # Replace with function body.
