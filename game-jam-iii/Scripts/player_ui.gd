extends Control
@onready var fuel_bar: TextureProgressBar = $HUD/FuelBar
@onready var o_2_bar: TextureProgressBar = $HUD/O2Bar
@onready var alt_text: Label = $HUD/AltText
@onready var dv_text: Label = $HUD/DVText
@onready var loss_screen: Panel = $LossScreen
@onready var label: Label = $LossScreen/Label
@onready var instructions: Panel = $Instructions
@onready var option_button: OptionButton = $Instructions/OptionButton
@onready var close_intro: Button = $Instructions/closeIntro
@onready var label_3: Label = $Instructions/Label3
@onready var quit_2: Button = $Instructions/Quit2

func _process(_delta: float) -> void:
	if (Input.is_action_pressed("pause")):
		quit_2.visible = true
		instructions.visible = !instructions.visible
	if(option_button.selected != -1 and option_button.visible == true):
		close_intro.visible = true
		var p : player = get_tree().get_first_node_in_group("player")
		if (option_button.selected == 0):
			p.setDifficulty("easy")		
		elif (option_button.selected == 1):
			p.setDifficulty("med")
		elif (option_button.selected == 2):
			p.setDifficulty("hard")
		else:
			print("E07 No valid button selected")
		option_button.visible = false
func update_values(o2, fuel, alt,spd) -> void:
	fuel_bar.value = fuel
	o_2_bar.value = o2
	alt_text.text = str(int(alt)) + " - M"
	dv_text.text = str(int(spd)) + " M/S"

func display_screen(a : int):
	if (a == 0):
		loss_screen.visible = true
		label.text = "You've reached you final destination and lived! \n You've saved the human race!"
	elif (a == 1):
		loss_screen.visible = true
		label.text = "You've flown directly into the sun and Died!!! \n Such a foolish fate indeed"
	elif(a == 2):
		loss_screen.visible = true
		label.text = "You've run out of oxygen in the void of space. \n if only you could have landed in time..."
	elif (a==3):
		loss_screen.visible = true
		label.text = "Lithobraking isnt such a great plan... \n Maybe your difficulty is a bit too high for you?"
	else:
		loss_screen.visible = true
		print("E05")
	Engine.time_scale = 0


func _on_try_again_pressed() -> void:
	get_tree().reload_current_scene()

func _on_close_intro_pressed() -> void:
	instructions.visible = false
	label_3.visible = false

func _on_quit_2_pressed() -> void:
	get_tree().quit()
