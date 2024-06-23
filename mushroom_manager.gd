extends Node2D

@export var mushroom_scene = preload("res://mushroom.tscn")
@export var intial_tree_amount = 5
@onready var navigation_region_2d = $"../NavigationRegion2D"
var view 

# Called when the node enters the scene tree for the first time.
func _ready():
	view = get_viewport_rect()
	for spawn in intial_tree_amount:
		var mushroom = mushroom_scene.instantiate()
		navigation_region_2d.add_child.call_deferred(mushroom)
		mushroom.global_position = avoid_center()
	await get_tree().create_timer(1).timeout
	navigation_region_2d.bake_navigation_polygon()


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
	print(Vector2(x,y))
	return Vector2(x,y)




func _on_spawn_timer_timeout():
	pass # Replace with function body.
