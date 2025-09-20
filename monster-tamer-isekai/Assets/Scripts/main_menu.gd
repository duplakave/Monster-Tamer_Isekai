extends Control

func  _ready():
	pass


func _on_start_pressed() -> void:
#	var started = _on_start_pressed()== true
	get_tree().change_scene_to_file("res://Assets/schenes/Main_Schene.tscn")


func _on_exit_pressed() -> void:
	get_tree().quit()

#func menu_music_play():
#	if started == true:
#		pass
	
