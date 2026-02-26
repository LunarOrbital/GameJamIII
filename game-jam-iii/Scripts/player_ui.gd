extends Control
@onready var fuel_bar: TextureProgressBar = $HUD/FuelBar
@onready var o_2_bar: TextureProgressBar = $HUD/O2Bar
@onready var alt_text: Label = $HUD/AltText

var alt : float
func update_values(o2, fuel, alt) -> void:
	fuel_bar.value = fuel
	o_2_bar.value = o2
	alt_text.text = str(int(alt)) + "- M"
