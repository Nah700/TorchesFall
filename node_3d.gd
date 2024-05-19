extends Node3D

var score = 0
@export var mob_scene: PackedScene
@onready var scoreLabel = $CanvasLayer/GameUI/Score
@onready var timerLabel = $CanvasLayer/GameUI/Timer


# Called when the node enters the scene tree for the first time.
func _ready():
	$MobTimer.timeout.connect(_on_mob_timer_timeout)
	$DespawnArea.body_entered.connect(_on_despawn_area_body_entered)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	var time = $GameTime.time_left
	timerLabel.text = "%d" % int(time)
	

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

func _on_despawn_area_body_entered(body): #décrémenation
	if body.is_in_group("mobs"):
		score -= 1
		if score < 0:
			score = 0
		scoreLabel.text = "Score: %d" % score
		body.queue_free()


func _on_detection_area_body_entered(body): #incrémentation
	if body.is_in_group("mobs"):
		score += 1
		scoreLabel.text = "Score: %d" % score 
		body.queue_free()
		$TorchEffect.play()
