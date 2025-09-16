extends Control

signal choice_selected

const ChoiceButtonSchene = preload("res://Assets/schenes/Player_choice.tscn")

@onready var dialog_line = %DialogLines
@onready var speaker_name = %SpeakerName
@onready var choice_list = %ChoiceList

const ANIMATION_SPEED : int = 30
var animate_text : bool = false
var current_visible_characters : int = 0

func  _ready():
	choice_list.hide()
	
func _process(delta):
	if animate_text:
		if dialog_line.visible_ratio < 1:
			dialog_line.visible_ratio += (1.0/dialog_line.text.length()) * (ANIMATION_SPEED * delta)
			current_visible_characters = dialog_line.visible_characters
		else:
			animate_text = false

func  change_line(speaker: String, line: String):
	speaker_name.text = speaker
	current_visible_characters = 0
	dialog_line.text = line
	dialog_line.visible_characters = 0
	animate_text = true
	
func display_choices(Choices: Array):
	for child in choice_list.get_children():
		child.queue_free()
	
	
	
	for choice in Choices:
		@warning_ignore("unused_variable")
		var choice_button = ChoiceButtonSchene.instantiate()
		choice_button.text = choice["text"]
		choice_button.pressed.connect(on_choice_button_pressed.bind(choice["goto"]))
		choice_list.add_child(choice_button)
		choice_list.show()




func on_choice_button_pressed(anchor: String):
	choice_selected.emit(anchor)
	choice_list.hide()
