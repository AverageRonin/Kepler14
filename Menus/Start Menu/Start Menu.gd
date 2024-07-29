extends Control



func _on_start_pressed():
	get_tree().change_scene_to_file("res://Assets/Levels/lvl0.tscn")


func _on_options_pressed():
	get_tree().change_scene_to_file("res://Menus/Options/options.tscn")


func _on_quit_pressed():
	get_tree().quit()
