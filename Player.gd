extends CharacterBody3D

var speed = 10.0
var gravity = -100
var jump_force = 15.0

func _ready():
	pass

func _process(delta):
	if (self.has_node("Model")):
		update_animation_paramaters()
	for child in self.get_children():
		if "@Node3D@" in child.name:
			child.name = "Model"
	handle_movement(delta)

func handle_movement(delta):
	var input_dir = Vector3.ZERO
	input_dir.x = Input.get_axis("move_left", "move_right")
	input_dir = input_dir.normalized()
	
	var direction = (transform.basis * input_dir).normalized()
	velocity.x = direction.x * speed
	velocity.z = direction.z * speed
	
	if input_dir.x != 0:
		var model = $Model
		if (model):
			if input_dir.x > 0:
				model.rotation_degrees.y = 90
			elif input_dir.x < 0:
				model.rotation_degrees.y = -90
			else:
				model.rotation_degrees.y = 0
	
	if not is_on_floor():
		velocity.y += gravity * delta
	else:
		velocity.y = 0
		if Input.is_action_just_pressed("jump"):
			velocity.y = jump_force
	move_and_slide()
	
func update_animation_paramaters():
	var animation_tree = $Model/AnimationTree
	if Input.is_action_pressed("move_left") or Input.is_action_pressed("move_right"):
		animation_tree["parameters/conditions/idle"] = false
		animation_tree["parameters/conditions/is_running"] = true
	else:
		animation_tree["parameters/conditions/idle"] = true
		animation_tree["parameters/conditions/is_running"] = false
