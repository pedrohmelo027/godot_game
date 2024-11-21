extends CharacterBody2D


const SPEED = 200.0
const JUMP_VELOCITY = -400.0
var direction : float
var atacando: bool
const NUMERO_COLISION = 24

@onready var animation := $AnimatedSprite2D as AnimatedSprite2D
var is_jumping := false


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		is_jumping = true
	elif is_on_floor():
		is_jumping = false

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction != 0:
		velocity.x = direction * SPEED
		animation.scale.x = direction
		if !is_jumping:
			animation.play("run")
	elif is_jumping:
		animation.play("jump")
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		animation.play("idle")
		return
		
	move_and_slide()
func animate():
	if atacando:
		animation.play("aatque")
		return
func _input(event: InputEvent):
	if Input.is_action_pressed("ATAQUE"):
		ataque()
func ataque():
	atacando = true
		
func fliph():
	if velocity.x > 0:
		$AnimatedSprite2D.flip_h = false
		$AttackArea/Collision.position.x = NUMERO_COLISION
	if velocity.x < 0:
		$AnimatedSprite2D.flip_h = true
 


func _on_animation_changed(ani_name):
	if ani_name == "aatque":
		atacando = false
