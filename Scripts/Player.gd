extends Node2D   # Node2D because we might move it later

var max_health := 100
var health := 100
var speed := 100

func _ready():
	print("Player ready")
	print_health()
	
	var potion_icon = load("res://Assets/Icons/potion.png")
	var sword_icon = load("res://Assets/Icons/sword.png")
	# Create some test items
	var potion = Item.new("potion", "Health Potion", potion_icon, 5)
	var sword = Item.new("sword", "Iron Sword", sword_icon, 1)

	# Add items to inventory
	Global.add_item(potion)
	Global.add_item(sword)

	# Print inventory to console
	print_inventory()

func _process(delta):
	var dir := Vector2.ZERO
	
	if Input.is_action_pressed("ui_right"):
		dir.x += 1
	if Input.is_action_pressed("ui_left"):
		dir.x -= 1
	if Input.is_action_pressed("ui_down"):
		dir.y += 1
	if Input.is_action_pressed("ui_up"):
		dir.y -= 1

	if dir != Vector2.ZERO:
		global_position += dir.normalized() * speed * delta
	
func _input(event):
	if event.is_action_pressed("ui_accept"): # Enter
		var potion = Item.new("potion", "Health Potion", null, 1)
		Global.add_item(potion)

func heal(amount: int):
	health = min(health + amount, max_health)
	print("Player healed by", amount)
	print_health()
	
func print_health():
	print("Player Health:", health, "/", max_health)

func print_inventory():
	print("----- Inventory -----")
	for i in Global.inventory.size():
		var slot = Global.inventory[i]
		if slot:
			print(i, ":", slot.name, "x", slot.quantity)
		else:
			print(i, ":", "Empty")
	print("---------------------")
