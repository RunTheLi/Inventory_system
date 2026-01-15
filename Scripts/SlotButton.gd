# SlotButton.gd
extends Button

class_name SlotButton

var slot_index: int

func _ready():
	print("SlotButton ready:", slot_index)

func _get_drag_data(at_position):
	var item = Global.inventory[slot_index]
	if item == null:
		return null

	var preview = TextureRect.new()
	preview.texture = item.icon
	preview.custom_minimum_size = Vector2(32, 32)
	set_drag_preview(preview)

	return slot_index


func _can_drop_data(at_position, data):
	return typeof(data) == TYPE_INT


func _drop_data(at_position, data):
	var from_index = data
	var to_index = slot_index
	Global.swap_items(from_index, to_index)
