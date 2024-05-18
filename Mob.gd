extends Node3D

# Variables for movement
var direction = Vector3.ZERO
var speed = 5.0

# Initialize the mob with its spawn position and the player's position
func initialize(spawn_position: Vector3, player_position: Vector3):
	global_transform.origin = spawn_position
	direction = (player_position - spawn_position).normalized() * Vector3(0, 1, 0)
	add_to_group("mobs")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if direction != Vector3.ZERO:
		translate(direction * speed * delta)


func _on_visible_on_screen_notifier_3d_screen_exited():
	pass
