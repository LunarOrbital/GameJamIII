extends Control
var fuel := 100.0
var o2 := 100.0
@onready var fuel_bar: TextureProgressBar = $Polygon2D/FuelBar
@onready var o_2_bar: TextureProgressBar = $Polygon2D/O2Bar

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	o_2_bar.value = o2
	fuel_bar.value = fuel
