extends Node

signal inventory_updated

@onready var pickup_scene = preload("res://Scenes/ItemPickup.tscn")

const INVENTORY_SIZE := 30

var inventory: Array = []
# Called when the node enters the scene tree for the first time.
func _ready():
	inventory.resize(INVENTORY_SIZE)
	for i in inventory.size():
		inventory[i] = null

func add_item(item: Item) -> bool:
	# 1️⃣ Try stacking
	for i in inventory.size():
		var slot = inventory[i]
		if slot and slot.id == item.id and slot.stackable:
			if slot.quantity < slot.max_stack:
				slot.quantity += item.quantity
				emit_signal("inventory_updated")
				return true
	
	# 2️⃣ Find empty slot
	for i in inventory.size():
		if inventory[i] == null:
			inventory[i] = item
			emit_signal("inventory_updated")
			return true
	
	return false # inventory full

func remove_item(slot_index: int, amount := 1):
	var item = inventory[slot_index]
	if item == null:
		return
		
	item.quantity -= amount
	if item.quantity <= 0:
		inventory[slot_index] = null
		
	emit_signal("inventory_updated")

func drop_item(item: Item, position: Vector2):
	var pickup_scene = preload("res://Scenes/PickupItem.tscn")
	var pickup = pickup_scene.instantiate()
	pickup.item = item
	pickup.global_position = position
	get_tree().current_scene.add_child(pickup)

func swap_items(from_index: int, to_index: int):
	if from_index == to_index:
		return

	var temp = inventory[from_index]
	inventory[from_index] = inventory[to_index]
	inventory[to_index] = temp

	emit_signal("inventory_updated")
