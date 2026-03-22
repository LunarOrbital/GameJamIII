extends Node3D
var numStars : int
@export var G := 600
@export var packed_star : PackedScene 
@onready var player2: player = $Player
@onready var end_star: Star = $EndStar
@onready var eye: Planet = $Eye

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	numStars = randi_range(7, 16)
	Engine.time_scale = 1
	for i in range(numStars):
		var newStar : RigidBody3D = packed_star.instantiate()
		add_child(newStar)
		newStar.position = Vector3(randi_range(-6000,6000),randi_range(-6000,6000),randi_range(-30000,30000))
		newStar.rotation = Vector3(randi_range(0,360),randi_range(0,360),randi_range(0,360))

func _physics_process(delta: float) -> void:
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
				if (dist<5000000):
					if (largeObj is Star):
						if (smallObj is Planet):
							if (smallObj.currSystem == largeObj):
								var force = G * (((smallObj.mass * largeObj.mass))/dist)
								var angle = smallObj.global_position.direction_to(largeObj.global_position)
								smallObj.apply_central_force(force * delta * angle)
						elif (smallObj is player):
							var force = G * (((smallObj.mass * largeObj.mass))/dist)
							var angle = smallObj.global_position.direction_to(largeObj.global_position)
							smallObj.apply_central_force(force * delta * angle)
					elif(largeObj is Planet):
						var force = G * (((smallObj.mass * largeObj.mass))/dist)
						var angle = smallObj.global_position.direction_to(largeObj.global_position)
						smallObj.apply_central_force(force * delta * angle)
						
	if (player2.global_position.distance_squared_to(end_star.global_position) <1000000):
		player2.dead = 0
	if (Input.is_action_just_pressed("reset")):
		print("EO1:Reset")
		get_tree().reload_current_scene()
	if (Input.is_action_just_pressed("quit")):
		print("EO2:Quit")
		get_tree().quit()

@onready var sprite_3d_2: Sprite3D = $Eye/Sprite3D2
@onready var sprite_3d_22: Sprite3D = $plinko/Sprite3D22
#huu
func _on_visible_on_screen_notifier_3d_screen_exited() -> void:
	if (player2.diff2 == "easy"):
		sprite_3d_2.visible = true
	elif (player2.diff2 == "hax"):
		sprite_3d_2.visible = true
		sprite_3d_2.scale = Vector3(564,512,532)
	elif (eye.global_position.distance_squared_to(player2.global_position)<500000):
		print("better than feldspar???!")
		sprite_3d_22.visible = true
		player2.player_ui.eye_star.visible = true
	eye.global_position = Vector3(randi_range(-6000,6000),randi_range(-6000,6000),randi_range(-30000,30000))
	eye.rotation = Vector3(randi_range(0,360),randi_range(0,360),randi_range(0,360))
	print("its solanumin time")
	
func _on_area_3d_body_entered(body: Node3D) -> void:
	if (body is player):
		print("u win plinko")
		body.o2Drain = 0
		body.isp = 0
		body.thrust *=1.1
		player2.player_ui.plinko_star.visible = true
