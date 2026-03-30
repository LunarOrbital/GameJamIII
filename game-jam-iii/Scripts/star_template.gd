extends RigidBody3D
class_name Star

@onready var timer: Timer = $Timer
@onready var star_mesh_temp_: MeshInstance3D = $"StarMesh(Temp)"
@onready var star_coll: CollisionShape3D = $starColl
var currSystem : RigidBody3D
@export var planet_temp : PackedScene 
@onready var explosion_player: AnimationPlayer = $ExplosionPlayer
@export var starCheck : String
var numPlanets : int

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	mass = randf_range(250,500)**2
	star_mesh_temp_.mesh = star_mesh_temp_.mesh.duplicate()
	var new_player : AnimationPlayer
	new_player = explosion_player.duplicate()
	explosion_player = new_player
	make_planet()
	Engine.time_scale = 1
	if (starCheck == "start"):
		explosion_player.play("explode")
	elif (starCheck != "end"):
		timer.start(randi_range(10,80))
func _process(_delta: float) -> void:
	star_coll.scale = star_mesh_temp_.scale

func make_planet() -> void:
	if (Value_Manager.spawnCount == 2):
		numPlanets = randi_range(3,7)
	else:
		numPlanets = randi_range(2,6)
	
	for i in range(numPlanets):
		var newPlanet : RigidBody3D = planet_temp.instantiate()
		add_child(newPlanet)
		newPlanet.position = Vector3((i*180)+randi_range(-50,50)+210, randf_range(-10,10), randf_range(-10,10))
		var spd = sqrt((600 * self.mass)/newPlanet.position.x)/5.64
		newPlanet.linear_velocity = Vector3(0,0,spd)
		newPlanet.currSystem = self
func _on_timer_timeout() -> void:
	explosion_player.play("explode")
	
func _on_explosion_player_animation_changed(_old_name: StringName, _new_name: StringName) -> void:
	queue_free()

func _on_body_entered(body: Node) -> void:
	if (body is player):
		body.dead = 1
	elif (body != self):
		if (body is Planet):
			print(body)
			body.queue_free()
		elif !(body.starCheck == "start" || body.starCheck == "end"):
			print(body)
			body.queue_free()
