extends Control
@onready var fuel_bar: TextureProgressBar = $HUD/FuelBar
@onready var o_2_bar: TextureProgressBar = $HUD/O2Bar

func update_values(o2, fuel) -> void:
	fuel_bar.value = fuel
	o_2_bar.value = o2
