extends RigidBody3D
class_name Star
@onready var timer: Timer = $Timer
var numPlanets : int
@onready var star_mesh_temp_: MeshInstance3D = $"StarMesh(Temp)"
@onready var star_coll: CollisionShape3D = $StarColl
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#var newScale = randi_range(20, 120)
	#star_mesh_temp_.scale = Vector3i(newScale, newScale, newScale)
	#star_coll.scale = Vector3i(newScale, newScale, newScale)
	timer.wait_time = randi_range(90, 240)
	numPlanets = randi_range(0,4)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
func _on_sun_kill_box_body_entered(body: Node3D) -> void:
	if (body is player):
		print("you burned up and died")
		get_tree().quit()
