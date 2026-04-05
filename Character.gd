extends CharacterBody2D

@export var SPEED = 300.0
@export var JUMP_VELOCITY = -400.0 
@export var ACCEL = 400.0
@export var HP = 10
@export var MaxHP = 10

@onready var jump_limit: bool = true
@onready var wall_jump_limit: bool = true
@onready var dash: bool = true
@onready var pivot: Node = $Pivote
@onready var animation_player : AnimationPlayer = $AnimationPlayer
@onready var animation_tree : AnimationTree = $AnimationTree
@onready var playback : AnimationNodeStateMachinePlayback = animation_tree["parameters/playback"]
@onready var current_state
@onready var hitbox : Hitbox
@onready var hurtbox : Hurtbox
@onready var jump_sfx: AudioStreamPlayer = $JumpSFX


enum State{
	Idle,
	Wall
	}
	
func _ready() -> void:
	animation_player.play("Idle")
	current_state = State.Idle

func _physics_process(delta: float) -> void:
	
	var move_input = Input.get_axis("move_left", "move_right")
		
	if move_input:
		velocity.x = move_toward(velocity.x, move_input * SPEED, ACCEL * delta)
		pivot.scale.x = sign(move_input)
		
	if is_on_floor():
		wall_jump_limit = true
		jump_limit = true
		dash = true
		
	if is_on_wall():
		current_state = State.Wall
	else:
		current_state = State.Idle
	
	match current_state:
		State.Idle:
			_physics_process_idle(delta)
		State.Wall:
			_physics_process_wall(delta)	
			
	move_and_slide()

func _physics_process_idle(delta: float) -> void:
	
	var move_input = Input.get_axis("move_left", "move_right")
	
	if move_input:
		playback.travel("Run")
	
	if not move_input and velocity.x != 0:
		playback.travel("Run -> Idle") 
	
	if not is_on_floor():
		velocity.y += get_gravity().y * delta
	
	if Input.is_action_just_pressed("jump") and is_on_floor(): 
		velocity.y = JUMP_VELOCITY
		jump_sfx.play()
		Debug.log("Normal Jump")
				
	if Input.is_action_just_pressed("jump") and not is_on_floor() and jump_limit:
		velocity.y = JUMP_VELOCITY
		jump_limit = false
		jump_sfx.play()
		Debug.log("Double Jump")
	
	if velocity.y == 0 and not is_on_floor():
		playback.travel("Start_Fall")
		
	if velocity.y > 0: 
		playback.travel("Fall_Loop")
		
	if velocity.x == 0 and is_on_floor():
		playback.travel("Run -> Idle")
	
	if Input.is_action_just_pressed("dash") and dash:
		velocity.x += 200 * pivot.scale.x
		playback.travel("Dash")

func _physics_process_wall(delta: float) -> void:
	
	if not is_on_floor():
		velocity.y += (get_gravity().y/3) * delta
		playback.travel("Wall_Slide")
		#Debug.log("Wall_Slide")
	
	if Input.is_action_just_pressed("jump") and wall_jump_limit:
		velocity.y += JUMP_VELOCITY
		wall_jump_limit = false
		jump_sfx.play()
		playback.travel("Jump")
		Debug.log("Wall_Jump") 

func take_DMG(dmg : int) -> void:
	HP -= dmg
	if HP <= 0:
		playback.travel("Death")
		queue_free()
		Debug.log("YOU DIED")
	
func deal_DMG(dmg : int) -> void:
	pass
