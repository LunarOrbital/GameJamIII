extends Node3D
var numStars : int
@onready var player: RigidBody3D = $Player


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	numStars = randi_range(10, 20)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
