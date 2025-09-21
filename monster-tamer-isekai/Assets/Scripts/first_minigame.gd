extends Node2D
var texture =load("res://Assets/cosmetics_and_sound/cosmetics/carrot.jpg")

func get_drag_data(at_position):
	var preview_texture = TextureRect.new()
	preview_texture.texture = texture
	preview_texture.expand_mode = 1
	preview_texture.size = Vector2(30,30)
	 
	var preview_control = Control.new()
	preview.add_child(preview_texture)
	
	set_drag_preview(preview_texture)
	texture = null
	return preview_texture.texture
	

func _can_drop_data(_pos, data):
	return data is Texture2D

func _drop_data(_pos, data):
	texture = data 
