extends Control
@export var main = preload("res://Scenes/main_scene.tscn")
@onready var credits: Panel = $Credits
@onready var main_menu: Panel = $MainMenu
@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer
@onready var options: Panel = $Options
@onready var fpo_check: CheckButton = $"Options/FPO Check"
@onready var extra_planets: CheckButton = $Options/ExtraPlanets
@onready var spawn_count: OptionButton = $Options/SpawnCount

func _ready() -> void:
	audio_stream_player.play(12)
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


func _on_options_pressed() -> void:
	main_menu.visible = false
	options.visible = true


func _on_options_close_pressed() -> void:
	main_menu.visible = true
	options.visible = false
	Value_Manager._update_values(fpo_check.button_pressed, extra_planets.button_pressed, spawn_count.selected)
