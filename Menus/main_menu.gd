extends Control

@onready var Start: Button = %Start
@onready var Continue: Button = %Continue
@onready var Options: Button = %Options
@onready var Credits: Button = %Credits
@onready var Quit: Button = %Quit

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Start.pressed.connect(_on_start_pressed)
	Continue.pressed.connect(_on_continue_pressed)
	Options.pressed.connect(_on_options_pressed)
	Credits.pressed.connect(_on_credits_pressed)
	Quit.pressed.connect(_on_quit_pressed)

func _on_start_pressed() -> void:
	get_tree().change_scene_to_file("res://Stage.tscn")

func _on_continue_pressed() -> void:
	pass

func _on_options_pressed() -> void:
	pass
	
func _on_credits_pressed() -> void:
	pass

func _on_quit_pressed() -> void:
	get_tree().quit()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
