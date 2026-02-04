extends Node3D
var numStars : int
var G := 60
@onready var player: RigidBody3D = $Player


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	numStars = randi_range(10, 20)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#begin gravity code
	for obj1 : RigidBody3D in get_tree().get_nodes_in_group("Gravity Objects"):
		for obj2 : RigidBody3D in get_tree().get_nodes_in_group("Gravity Objects"):
			if (obj2 != obj1):
				var smallObj : RigidBody3D
				var largeObj : RigidBody3D
				if (obj1.mass < obj2.mass):
					smallObj = obj1
					largeObj = obj2
				else:
					smallObj = obj2
					largeObj = obj1
				var dist = smallObj.global_position.distance_squared_to(largeObj.global_position)
				var force = G * (((smallObj.mass * largeObj.mass))/dist)
				var angle = smallObj.global_position.direction_to(largeObj.global_position)
				smallObj.apply_central_force(force * delta * angle)
				print(smallObj.mass)
				print(smallObj.linear_velocity)
			
	if (Input.is_action_just_pressed("reset")):
		print("EO1:Reset")
		get_tree().reload_current_scene()
	if (Input.is_action_just_pressed("quit")):
		print("EO2:Quit")
		get_tree().quit()
