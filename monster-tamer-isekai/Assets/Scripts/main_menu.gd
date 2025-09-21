extends Control

@onready var play: Button = %play
@onready var exit: Button = %exit

func  _ready():
	play.pressed.connect(_on_start_pressed)
	exit.pressed.connect(_on_exit_pressed)
	ScheneManager.transition_out_completed.connect(on_start_completed, CONNECT_ONE_SHOT)


func _on_start_pressed():
	ScheneManager.transition_out()
	
func on_start_completed():
	get_tree().change_scene_to_file("res://Assets/schenes/first_day.tscn")

func _on_exit_pressed():
	get_tree().quit()

#func menu_music_play():
#	if started == true:
#		pass
	
