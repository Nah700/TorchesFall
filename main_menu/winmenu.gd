extends Control

func _on_game_time_timeout():
	get_tree().change_scene_to_file("res://main_menu/menu.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	self.visible = true
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
