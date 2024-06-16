extends CharacterBody2D


const SPEED = 300.0

@onready var nav_agent := $NavigationAgent2D as NavigationAgent2D


func _physics_process(_delta: float) -> void:
	if Input.is_action_just_pressed("click"):
		makepath(get_global_mouse_position())
	var direction = to_local(nav_agent.get_next_path_position()).normalized()
	velocity = direction * SPEED
	move_and_slide()

func makepath(target):
	nav_agent.target_position = target
	print(nav_agent.target_position)
