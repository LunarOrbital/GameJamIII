extends RigidBody3D
class_name Star
@onready var timer: Timer = $Timer
var numPlanets : int
@onready var star_mesh_temp_: MeshInstance3D = $"StarMesh(Temp)"
@onready var star_coll: CollisionShape3D = $starColl
@onready var planet: Planet = $Planet
var sizeSpd = 1.0002
@export var spdCurve : Curve
var startTime : int
@onready var sun_kill_box: Area3D = $SunKillBox
var exploding : bool = false
const STAR_EXPLODE = preload("uid://ctedgerv5kq3b")
@onready var timer_2: Timer = $Timer2
var boo := false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	planet.linear_velocity = Vector3(30,0,0)
	startTime = randi_range(0, 60)
	timer.wait_time -= startTime
	timer.start()
func star_progress_ratio() -> float:
	return 1.0-(timer.time_left/400)
	
func _process(_delta: float) -> void:
	sizeSpd = (star_progress_ratio()/1200)+1
	if (exploding):
		sizeSpd = .9
		Engine.time_scale = 1
		if (star_mesh_temp_.scale <= Vector3(.25,.25,.25)):
			sizeSpd = 5
			timer_2.start()
			boo = true
			exploding = false
	star_mesh_temp_.scale *=sizeSpd
	star_coll.scale *= sizeSpd
	sun_kill_box.scale *= sizeSpd
	star_mesh_temp_.mesh.material.albedo_color.g -= star_progress_ratio()*(sizeSpd/70)
	if (star_progress_ratio() >= 1 && !boo):
		star_mesh_temp_.mesh.material = STAR_EXPLODE
		exploding = true
		print("boom")
	print(star_progress_ratio())
func _on_sun_kill_box_body_entered(body: Node3D) -> void:
	if (body is player):
		print("you burned up and died")
		get_tree().quit()
	elif (body != self):
		print(body)
		body.queue_free()


func _on_timer_2_timeout() -> void:
	queue_free()
