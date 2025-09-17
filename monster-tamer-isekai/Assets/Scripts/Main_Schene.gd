extends Node2D

@onready var mc = %MC
@onready var dialog_ui = %"Dialog UI"
@onready var background = %Background


var dialog_index: int = 0

var dialog_lines: Array = []

func _ready():
	dialog_lines = load_dialog("res://Assets/storytxt/ForestMonologue.json")
	dialog_index = 0
	process_current_line()
	dialog_ui.choice_selected.connect(on_choice_selected)

func _input(event):
	var line = dialog_lines[dialog_index]
	var has_choices = line.has("choices")
	if event.is_action_pressed("next_line") and not has_choices:
		if dialog_index < len(dialog_lines) -1:
			dialog_index += 1
			process_current_line()


	
func get_anchor_position(anchor: String):
	for i in range(dialog_lines.size()):
		if dialog_lines[i].has("anchor") and dialog_lines[i]["anchor"] == anchor:
			return i
			
	#error for no dialog option (not necessary, but good to have 'cus I be stoopid sometimes:
	printerr("Error: No Anchor(dialog options) found '" + anchor + "'")
	return null
	
func process_current_line():
	var line = dialog_lines[dialog_index] 
	#location change
	
	if line.has("location"):
		var background_file = "res://Assets/cosmetics_and_sound/background/" + line["location"] + ".png"
		background.texture = load(background_file)
		dialog_index += 1
		process_current_line()
		return
	
	#check for dialog options
	if line.has("goto"):
		dialog_index = get_anchor_position(line["goto"])
		process_current_line()
		return
	if line.has("anchor"):
		dialog_index += 1
		process_current_line()
		return
	
	if line.has("choices"):
		dialog_ui.display_choices(line["choices"])
	else:
		#reading dialog
		dialog_ui.change_line(line["speaker"], line["text"])
	
func load_dialog(file_path):
	#loading dialog and some error management:
	if not FileAccess.file_exists(file_path):
		printerr("Error: File does not exist: ", file_path)
		return null
	
	var  file = FileAccess.open(file_path, FileAccess.READ)
	if file == null:
		printerr("Error: cant open file: ", file_path)
		return null
	
	var content = file.get_as_text()
	var json_content = JSON.parse_string(content)
	if json_content == null:
		printerr("Error: Failed to parse .Json from file: ", file_path)
	return json_content

func on_choice_selected(anchor: String):
	dialog_index = get_anchor_position(anchor)
	process_current_line()
