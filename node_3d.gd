extends Node3D

@export var mob_scene: PackedScene

# Called when the node enters the scene tree for the first time.
func _ready():
	$MobTimer.timeout.connect(_on_mob_timer_timeout)
	$DespawnArea.body_entered.connect(_on_despawn_area_body_entered)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_mob_timer_timeout():
	var mob = mob_scene.instantiate()
	var mob_spawn_location = $SpawnArea
	var origin = mob_spawn_location.global_transform.origin
	var spawn_position = Vector3(
		randf_range(origin.x - 10, origin.x + 10),
		origin.y,
		origin.z
	)
	var player_position = $Player.global_transform.origin
	mob.initialize(spawn_position, player_position)
	add_child(mob)

func _on_despawn_area_body_entered(body):
	if body.is_in_group("mobs"):
		body.queue_free()

