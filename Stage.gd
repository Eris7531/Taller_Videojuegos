extends Node2D

var area_2D

@onready var pause_menu: Control = $PauseMenu


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	area_2D = $Area2D
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("restart"):
		get_tree().reload_current_scene()
		Debug.log("Restart")
		
	
	
func _on_body_entered(body : Node2D) -> void:
	if body.is_in_group("Player"):
		Debug.log("Hitbox Colition")
	
