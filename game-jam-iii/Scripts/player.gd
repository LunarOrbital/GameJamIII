extends RigidBody3D
class_name player
@export var fuel := 100.0
var currentSystem : RigidBody3D
var thrust := 0.0
var isp = 0.0
var SASSens := 400.0
@export var currSystem : RigidBody3D
@onready var rvs_cam: Camera3D = $rvsCam
@onready var _3_rd_cam: Camera3D = $"3rdCam"
var closest := 99999999.9
var closestObj : RigidBody3D 
@onready var player_ui: Control = $PlayerUI
var o2 := 100.0
var landed : bool = false
var landedAlt : float
var dead := -1
var o2Drain : float = 0.0
@onready var engine_sfx: AudioStreamPlayer = $EngineSFX
@onready var music: AudioStreamPlayer = $music
var engine : bool
@onready var engine_particles: GPUParticles3D = $EngineParticles
var diff2 : String
func setDifficulty(diff :String) -> void:
	diff2 = diff
	thrust = 30000
	isp = .1
	o2Drain = 0.05
	if (diff == "hard"):
		o2Drain *= 2
		isp *=2
		thrust /= 2
		SASSens /=1.5
	elif(diff == "med"):
		o2Drain = .064
		isp = .05
	elif(diff == "easy"):
		o2Drain *= .5
		isp *=.5
		thrust *= 1.3
func _physics_process(delta: float) -> void:
	if (self.global_position.distance_to(get_tree().get_first_node_in_group("endstar").global_position) < 1000):
		dead = 0
	for obj in get_tree().get_nodes_in_group("Gravity Objects"):
		if (obj != self):
			var newDist = global_position.distance_to(obj.global_position)
			if (newDist < closest) :
				closest = newDist
				closestObj = obj
	if !(landed):
		o2 -=o2Drain
		if (o2 <= 0):
			dead = 2
	else:
		if (o2 < 100):
			o2 += 1
		if (fuel < 100):
			fuel += 1
	#make more accurate
	var spd2 = linear_velocity.x + linear_velocity.y + linear_velocity.z
	if (closestObj != null):
		var alt = global_position.distance_to(closestObj.global_position)
		player_ui.update_values(o2,fuel,alt,spd2)
		currSystem = closestObj
	else:
		player_ui.update_values(o2,fuel,0,spd2)
	if (dead > -1):
		player_ui.display_screen(dead)
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
	if(Input.is_action_pressed("Forward") || Input.is_action_pressed("Left") || Input.is_action_pressed("Right") || Input.is_action_pressed("Back")) || Input.is_action_pressed("Down") || Input.is_action_pressed("Up"):
		if (engine_sfx.playing == false):
			engine_sfx.playing = true
			engine_particles.emitting = true
	else:
		engine_sfx.playing = false
		engine_particles.emitting = false
const SFX___DEATH_EXPLOSION = preload("uid://cybnk2g0wdy0n")
const SFX___MAIN_ENGINE_THRUST = preload("uid://xwie06lt3bj7")
const SFX___SUCCESS = preload("uid://cb4crtjr6dt6q")
const WIZARDTORIUM = preload("uid://btly817bglwrl")
