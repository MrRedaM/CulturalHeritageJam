extends KinematicBody2D

const UP_DIRECTION := Vector2.UP

export var speed := 600.0
export var jump_strength := 1500.0
export var max_jumps := 2
export var double_jump_strength := 1200.0
export var gravity := 4500.0

var _jumps := 0
var _vel := Vector2.ZERO

onready var _skin: Node2D = $Skin
onready var _anim: AnimationPlayer = $Skin/AnimationPlayer
onready var _start_scale: Vector2 = _skin.scale

func _ready():
	pass


func _process(delta):
	_vel.x = Input.get_axis("ui_left", "ui_right") * speed
	_vel.y += gravity * delta
	
	var is_falling := _vel.y > 0.0 and not is_on_floor()
	var is_jumping := Input.is_action_just_pressed("ui_up") and is_on_floor()
	var is_double_jumping := Input.is_action_just_pressed("ui_up") and not is_on_floor()
#	var is_jump_cancelled := Input.is_action_just_pressed("ui_up") and _vel.y < 0.0
	var is_idling := is_on_floor() and is_zero_approx(_vel.x)
	var is_running := is_on_floor() and not is_zero_approx(_vel.x)
	
	if is_jumping:
		_jumps += 1
		_vel.y = -jump_strength
	elif is_double_jumping:
		_jumps += 1
		if _jumps <= max_jumps:
			_vel.y = -double_jump_strength
#	elif is_jump_cancelled:
#		_vel.y = 0.0
	elif is_idling or is_running:
		_jumps = 0
	
	_vel = move_and_slide(_vel, UP_DIRECTION)
	
	if not is_zero_approx(_vel.x):
		_skin.scale.x = sign(_vel.x) * _start_scale.x
	
	if is_jumping or is_double_jumping:
		_anim.play("jump")
	elif is_running:
		_anim.play("run")
	elif is_falling:
		pass
	elif is_idling:
		_anim.play("idle")
