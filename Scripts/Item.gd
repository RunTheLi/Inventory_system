# Item.gd
class_name Item

var id: String
var name: String   # This is now safe, no Node inheritance
var icon: Texture2D
var stackable: bool = true
var quantity: int = 1
var max_stack: int = 99

func _init(_id: String, _name: String, _icon: Texture2D, _qty := 1):
	id = _id
	name = _name
	icon = _icon
	quantity = _qty

func use(target):
	match id:
		"potion":
			target.heal(20)
		"sword":
			print("Sword used (equip later)")
		_:
			print("Nothing happens")	
