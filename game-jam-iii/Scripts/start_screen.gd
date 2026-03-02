extends Control
@export var main = preload("res://Scenes/main_scene.tscn")
@onready var credits: Panel = $Credits
@onready var main_menu: Panel = $MainMenu

func _on_end_game_pressed() -> void:
	get_tree().quit()

func _on_credits_pressed() -> void:
	main_menu.visible = false
	credits.visible = true

func _on_start_button_pressed() -> void:
	get_tree().change_scene_to_packed(main)


func _on_close_credits_pressed() -> void:
	main_menu.visible = true
	credits.visible = false
