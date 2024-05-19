extends Control

# table pour les skins
var player_skins = [
	{
		"name": "Default",
		"model_path": "res://Skins/default_skin.tscn",
	},
	{
		"name": "Knight",
		"model_path": "res://Skins/knight_skin.tscn",
	},
]

@onready var player = get_node("/root/World/Player")

func change_player_skin(skin_index):
	var selected_skin = player_skins[skin_index]
	var scene = load(selected_skin["model_path"]) 
	var new_scene_instance = scene.instantiate()
	var new_model = new_scene_instance
	if player.has_node("Model"):
		player.get_node("Model").queue_free()
	new_model.name = "Model"
	player.add_child(new_model)
	for child in new_scene_instance.get_children():
		if child != new_model:
			player.add_child(child)

func remove_skin_buttons():
	for child in get_children():
		if child is Button:
			child.queue_free()

func create_skin_buttons():
	var button_position_y = 300
	for i in range(player_skins.size()):
		var skin = player_skins[i]
		var button = Button.new()
		button.text = skin["name"]
		button.position = Vector2(1200, button_position_y)
		button_position_y += 35
		button.connect("pressed", _on_skin_button_pressed.bind(i))
		add_child(button)

func _on_skin_button_pressed(skin_index):
	change_player_skin(skin_index)

func _ready():
	$AnimationPlayer.play("RESET")
	change_player_skin(0)

func resume():
	get_tree().paused = false
	$AnimationPlayer.play_backwards("blur")
	remove_skin_buttons()

func pause():
	get_tree().paused = true
	$AnimationPlayer.play("blur")
	create_skin_buttons()

func test_esc():
	if Input.is_action_just_pressed("ui_cancel"):
		if get_tree().paused:
			resume()
		else:
			pause()

func _process(_delta):
	test_esc()

func _on_resume_pressed():
	resume()

func _on_quit_pressed():
	get_tree().quit()
