extends RigidBody3D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var input := Vector3.ZERO
	input.x = Input.get_axis("move_left", "move_right")
	if Input.is_action_just_pressed("jump"):
		input.y += 15
	
	apply_central_force(input * 1200.0 * delta)
