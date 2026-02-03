extends RigidBody3D
@export var fuel := 100.0
var thrust := 1000
var isp = .01
var SASSens := 10
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
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
