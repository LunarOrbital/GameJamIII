extends RigidBody3D
class_name Planet
var resources : int

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	resources = randi_range(10, 100)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
