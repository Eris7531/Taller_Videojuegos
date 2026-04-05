extends Control

@onready var Resume: Button = %Resume
@onready var Retry: Button = %Retry
@onready var Options: Button = %Options
@onready var Menu: Button = %Menu
@onready var Quit: Button = %Quit


func _ready() -> void:
	hide()
	Resume.pressed.connect(_on_resume_pressed)
	Retry.pressed.connect(_on_retry_pressed)
	Options.pressed.connect(_on_options_pressed)
	Menu.pressed.connect(_on_menu_pressed)
	Quit.pressed.connect(_on_quit_pressed)
	
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("pauseMenu"):
		get_tree().paused = not get_tree().paused
		visible = get_tree().paused
		
func _on_resume_pressed() -> void:
	get_tree().paused = false
	hide()
	
func _on_retry_pressed() -> void:
	get_tree().paused = false
	get_tree().reload_current_scene()

func _on_options_pressed() -> void:
	pass
	
func _on_menu_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://Menus/MainMenu.tscn")

func _on_quit_pressed() -> void:
	get_tree().quit()
