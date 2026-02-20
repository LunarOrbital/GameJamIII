extends RigidBody3D
class_name Star

@onready var timer: Timer = $Timer
@onready var star: MeshInstance3D = $Star

@onready var star_coll: CollisionShape3D = $starColl
@export var planet_temp : PackedScene 
@onready var explosion_player: AnimationPlayer = $ExplosionPlayer
@export var starCheck : String
var numPlanets : int
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	timer.start(randi_range(1,40))
	make_planet()
	
func _process(_delta: float) -> void:
	star_coll.scale = star.scale
	
func make_planet() -> void:
	for i in range(1,randi_range(2,4)):
		var newPlanet : RigidBody3D = planet_temp.instantiate()
		add_child(newPlanet)
		newPlanet.position = Vector3((i*100)+randi_range(-50,50)+100, 0.0, 0.0)
		newPlanet.mass *= randf_range(.8,1.2)
		var spd = sqrt((60*mass)/newPlanet.position.x)/5.64
		newPlanet.linear_velocity = Vector3(0,0,spd)
		var rf = randf_range(-.8,1.2)
		newPlanet.scale*=Vector3(rf,rf,rf)
		print(i)

func _on_timer_timeout() -> void:
	explosion_player.play("explode")

func _on_explosion_player_animation_changed(_old_name: StringName, _new_name: StringName) -> void:
	print("exploded")
	queue_free()

func _on_body_entered(body: Node) -> void:
	if (body is player):
		print("you burned up and died")
		get_tree().quit()
	elif (body != self):
		if (body is Planet):
			print(body)
			body.queue_free()
		elif !(body.starCheck == "start" || body.starCheck == "end"):
			print(body)
			body.queue_free()
