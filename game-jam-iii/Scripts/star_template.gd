extends RigidBody3D
class_name Star

@onready var timer: Timer = $Timer
@onready var star_mesh_temp_: MeshInstance3D = $"StarMesh(Temp)"
@onready var star_coll: CollisionShape3D = $starColl
@export var planet_temp : PackedScene 
@onready var sun_kill_box: Area3D = $SunKillBox
@onready var explosion_player: AnimationPlayer = $ExplosionPlayer

var numPlanets : int
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	timer.start(randi_range(1,40))
	for i in range(randi_range(1,3)):
		make_planet()
		print(i)
func make_planet() -> void:
	var newPlanet : RigidBody3D = planet_temp.instantiate()
	add_child(newPlanet)
	newPlanet.position = Vector3( randi_range(4,8)*50, 0.0, 0.0)
	newPlanet.mass *= randf_range(.8,1.2)
	var spd = sqrt((60*mass)/newPlanet.position.x)/6
	newPlanet.linear_velocity = Vector3(0,0,spd)
	print(newPlanet.position)
	
func _on_sun_kill_box_body_entered(body: Node3D) -> void:
	if (body is player):
		print("you burned up and died")
		get_tree().quit()
	elif (body != self):
		print(body)
		body.queue_free()

func _on_timer_timeout() -> void:
	explosion_player.play("explode")

func _on_explosion_player_animation_changed(_old_name: StringName, _new_name: StringName) -> void:
	print("exploded")
	queue_free()
