# InventoryUI.gd
extends CanvasLayer

@onready var player = get_tree().get_first_node_in_group("player")
@onready var inventory_grid: GridContainer = $InventoryGrid

func _ready():
	# Connect to Global signal
	Global.connect("inventory_updated", Callable(self, "_update_inventory"))
	
	#Initial display
	_update_inventory()
	
func _update_inventory():
	for child in inventory_grid.get_children():
		child.queue_free()

	for i in Global.inventory.size():
		var item = Global.inventory[i]
		var button = SlotButton.new()
		button.slot_index = i
		button.custom_minimum_size = Vector2(64, 64)
		
		if item:
			button.gui_input.connect(_on_slot_gui_input.bind(i))
		else:
			button.disabled = true
		# --- Slot content ---
		var box = VBoxContainer.new()
		box.alignment = BoxContainer.ALIGNMENT_CENTER
		
		var icon = TextureRect.new()
		icon.custom_minimum_size = Vector2(32, 32)
		icon.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
		icon.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED
		
		if item and item.icon:
			icon.texture = item.icon
		
		var label = Label.new()
		label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
		
		if item:
			label.text = "x%d" % item.quantity
		else:
			label.text = ""
		
		box.add_child(icon)
		box.add_child(label)
		button.add_child(box)
		
		inventory_grid.add_child(button)

func _on_slot_gui_input(event: InputEvent, slot_index: int):
	if event is InputEventMouseButton and event.pressed:
		match event.button_index:
			MOUSE_BUTTON_LEFT:
				_use_item(slot_index)
			MOUSE_BUTTON_RIGHT:
				_drop_item(slot_index)

func _use_item(slot_index: int):
	var item = Global.inventory[slot_index]
	if item == null:
		return

	item.use(player)
	Global.remove_item(slot_index, 1)

func _drop_item(slot_index: int):
	var item = Global.inventory[slot_index]
	if item == null:
		return
		
	var dropped_item = Item.new(
		item.id,
		item.name,
		item.icon,
		1
	)

	Global.remove_item(slot_index, 1)
	Global.drop_item(dropped_item, player.global_position)
