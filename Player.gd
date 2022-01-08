extends KinematicBody2D

export var GRAVITY = 1000
export var MOVE_SPEED = 3000
export var MAX_SPEED = 600
export var JUMP_STRENGTH = 500
export var FRICTION = 0.2

onready var GunSprite = $GunSprite

var velocity = Vector2.ZERO

func _physics_process(delta):
	# movement
	move(delta)
	
	var mousePos = get_viewport().get_mouse_position()
	var mouseVec = mousePos - position
	var mouseDir = mouseVec.angle()
	
	GunSprite.set_rotation(mouseDir)
	
	if Input.get_action_strength("fire_gun"):
		

func move(delta):
	var move = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	
	if move != 0:
		velocity.x += move * MOVE_SPEED * delta
	
	if abs(velocity.x) > MAX_SPEED || move == 0:
		velocity.x = lerp(velocity.x, 0, FRICTION)
	
	# jump
	if Input.get_action_strength("ui_up") && is_on_floor():
		velocity.y -= JUMP_STRENGTH
	
	# apply gravity
	velocity.y += GRAVITY * delta
	
	# move player
	velocity = move_and_slide(velocity, Vector2.UP)
