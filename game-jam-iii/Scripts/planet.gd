extends RigidBody3D
class_name Planet
var resources : int
@export var iceTexture : PackedScene
@export var gasTexture : PackedScene 
@export var lavaTexture : PackedScene 
@export var deadTexture : PackedScene 
@export var sandTexture : PackedScene 
@export var earthTexture : PackedScene 
@export var currSystem : RigidBody3D
@onready var planet_coll: CollisionShape3D = $PlanetColl

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	mass = randi_range(500,1500)
	resources = randi_range(10, 100)
	var newText : PackedScene 
	var i = randi_range(0,2)
	if mass<1000:
		if (i == 0):
			newText = iceTexture
		if (i == 1):
			newText = sandTexture
		if (i == 2):
			newText = earthTexture
	else:
		if (i == 0):
			newText = deadTexture
		if (i == 1):
			newText = lavaTexture
		if (i == 2):
			newText = gasTexture
	var newerText : MeshInstance3D = newText.instantiate()
	add_child(newerText)
	newerText.global_position = self.global_position
	var scale2 = Vector3(mass/20,mass/20,mass/20)
	newerText.scale = scale2
	planet_coll.scale = scale2

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
