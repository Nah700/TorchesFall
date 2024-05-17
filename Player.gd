extends CharacterBody3D

var speed = 5.0
var gravity = -100
var jump_force = 15.0

func _ready():
	pass

func _process(delta):
	handle_movement(delta)

func handle_movement(delta):
	var input_dir = Vector3.ZERO
	input_dir.x = Input.get_axis("move_left", "move_right")
	input_dir = input_dir.normalized()
	
	var direction = (transform.basis * input_dir).normalized()
	velocity.x = direction.x * speed
	velocity.z = direction.z * speed
	
	if not is_on_floor():
		velocity.y += gravity * delta
	else:
		velocity.y = 0
		if Input.is_action_just_pressed("jump"):
			velocity.y = jump_force
	move_and_slide()
