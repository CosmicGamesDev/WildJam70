extends Node2D

@export var tree_scene = preload("res://tree.tscn")
@export var intial_tree_amount = 5
@onready var navigation_region_2d = $"../NavigationRegion2D"
var view
# Called when the node enters the scene tree for the first time.
func _ready():
	view = get_viewport_rect()
	for spawn in intial_tree_amount:
		var tree = tree_scene.instantiate()
		navigation_region_2d.add_child.call_deferred(tree)
		tree.global_position = avoid_center()
	await get_tree().create_timer(1).timeout

func avoid_center():
	var x = 8
	var y = 8
	if randi_range(0,1):
		x = randi_range(8,view.size.x/2 - 72)
	else:
		x = randi_range(view.size.x/2 - 72, view.size.x - 8)
	if randi_range(0,1):
		y = randi_range(8,view.size.y/2 - 72)
	else:
		y = randi_range(view.size.y/2 - 72, view.size.y - 8)
	return Vector2(x,y)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_spawn_timer_timeout():
	pass # Replace with function body.
