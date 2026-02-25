extends RigidBody3D
class_name player
@export var fuel := 200.0
var currentSystem : RigidBody3D
var thrust := 30000
var isp = .1
var SASSens := 400
@export var currSystem : RigidBody3D
@onready var rvs_cam: Camera3D = $rvsCam
@onready var _3_rd_cam: Camera3D = $"3rdCam"
var closest := 99999999.9
var closestObj : RigidBody3D 
@onready var player_ui: Control = $PlayerUI
var o2 := 100.0
var landed : bool = false
var landedAlt : float
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	for obj in get_tree().get_nodes_in_group("Gravity Objects"):
		var newDist = global_position.distance_to(obj.global_position)
		if (newDist < closest):
			closest = newDist
			closestObj = obj
	if !(landed):
		o2 -=.1
	else:
		if (o2 < 100):
			o2 += .5
		if (fuel < 100):
			fuel += 1
	player_ui.update_values(o2,fuel)
	
	
	if (Input.is_action_just_pressed("switchCam")):
		_3_rd_cam.current = !_3_rd_cam.current
	if (fuel >= 0):
		if (Input.is_action_pressed("Forward")):
			apply_central_force(-global_basis.z * thrust * delta)
			fuel -= isp
		if (Input.is_action_pressed("Back")):
			apply_central_force(global_basis.z * thrust * delta)
			fuel -= isp
		if (Input.is_action_pressed("Left")):
			apply_central_force(-global_basis.x * thrust * delta)
			fuel -= isp
		if (Input.is_action_pressed("Right")):
			apply_central_force(global_basis.x * thrust * delta)
			fuel -= isp
		if (Input.is_action_pressed("Up")):
			apply_central_force(global_basis.y * thrust * delta)
			fuel -= isp
		if (Input.is_action_pressed("Down")):
			apply_central_force(-global_basis.y * thrust * delta)
			fuel -= isp
	if (true):
		if (Input.is_action_pressed("PanLeft")):
			apply_torque(global_basis.y * SASSens * delta)
		if (Input.is_action_pressed("PanRight")):
			apply_torque(-global_basis.y * SASSens * delta)
		if (Input.is_action_pressed("PanUp")):
			apply_torque(global_basis.x * SASSens * delta)
		if (Input.is_action_pressed("PanDown")):
			apply_torque(-global_basis.x * SASSens * delta)
		if (Input.is_action_pressed("RollLeft")):
			apply_torque(global_basis.z * SASSens * delta)
		if (Input.is_action_pressed("RollLeft")):
			apply_torque(-global_basis.z * SASSens * delta)
