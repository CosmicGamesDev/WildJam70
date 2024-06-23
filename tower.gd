extends Sprite2D
@onready var spawn_point = $SpawnPoint
@onready var gnome_scene = preload("res://gnome.tscn")
var mushroom_count = 0
@export var nav_region : NavigationRegion2D
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_pickup_area_area_entered(area):
	var parent = area.get_parent() as Node2D 
	if parent.is_in_group("gnome") and parent.state == SelectionManager.action_types.returning:
		parent.state = SelectionManager.action_types.idle
		if parent.current_item.is_in_group("mushroom"):
			parent.has_item = false
			parent.current_item.queue_free()
			parent.current_item = null
			mushroom_count += 1
		if mushroom_count == 5:
			var gnome = gnome_scene.instantiate()
			nav_region.call_deferred("add_child", gnome)
			gnome.global_position = spawn_point.global_position
			mushroom_count = 0
