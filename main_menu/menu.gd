extends Control

func _ready():
	if (GlobalVariables.score > 0):
		$MarginContainer/VBoxContainer/ScoreLabel.text = "Score: %d" % GlobalVariables.score

func _on_play_pressed():
	GlobalVariables.score = 0
	get_tree().change_scene_to_file("res://node_3d.tscn")



func _on_quit_pressed():
	get_tree().quit()
